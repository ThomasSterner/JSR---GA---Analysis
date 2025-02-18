/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.commons.csv;

import static org.apache.commons.csv.Constants.BACKSPACE;
import static org.apache.commons.csv.Constants.CR;
import static org.apache.commons.csv.Constants.FF;
import static org.apache.commons.csv.Constants.LF;
import static org.apache.commons.csv.Constants.TAB;
import static org.apache.commons.csv.Token.Type.COMMENT;
import static org.apache.commons.csv.Token.Type.EOF;
import static org.apache.commons.csv.Token.Type.EORECORD;
import static org.apache.commons.csv.Token.Type.TOKEN;
import static org.apache.commons.csv.TokenMatchers.hasContent;
import static org.apache.commons.csv.TokenMatchers.matches;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import java.io.IOException;
import java.io.StringReader;
import org.junit.Before;
import org.junit.Test;
import org.junit.Ignore;

/**
 */
public class LexerTest {

    private CSVFormat formatWithEscaping;

    @Before
    public void setUp() {
        formatWithEscaping = CSVFormat.DEFAULT.withEscape('\\');
    }

    @SuppressWarnings("resource")
    private Lexer createLexer(final String input, final CSVFormat format) {
        return new Lexer(format, new ExtendedBufferedReader(new StringReader(input)));
    }

    @Test
    public void testSurroundingSpacesAreDeleted() throws IOException {
        final String code = "noSpaces,  leadingSpaces,trailingSpaces  ,  surroundingSpaces  ,  ,,";
        try (final Lexer parser = createLexer(code, CSVFormat.DEFAULT.withIgnoreSurroundingSpaces())) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "noSpaces"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "leadingSpaces"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "trailingSpaces"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "surroundingSpaces"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testSurroundingTabsAreDeleted() throws IOException {
        final String code = "noTabs,\tleadingTab,trailingTab\t,\tsurroundingTabs\t,\t\t,,";
        try (final Lexer parser = createLexer(code, CSVFormat.DEFAULT.withIgnoreSurroundingSpaces())) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "noTabs"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "leadingTab"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "trailingTab"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "surroundingTabs"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testIgnoreEmptyLines() throws IOException {
        final String code = "first,line,\n" + "\n" + "\n" + "second,line\n" + "\n" + "\n" + "third line \n" + "\n" + "\n" + "last, line \n" + "\n" + "\n" + "\n";
        final CSVFormat format = CSVFormat.DEFAULT.withIgnoreEmptyLines();
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "first"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "line"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "second"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "line"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "third line "));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "last"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, " line "));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    @Test
    public void testComments() throws IOException {
        final String code = "first,line,\n" + "second,line,tokenWith#no-comment\n" + "# comment line \n" + "third,line,#no-comment\n" + "# penultimate comment\n" + "# Final comment\n";
        final CSVFormat format = CSVFormat.DEFAULT.withCommentMarker('#');
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "first"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "line"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "second"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "line"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "tokenWith#no-comment"));
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "comment line"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "third"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "line"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "#no-comment"));
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "penultimate comment"));
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "Final comment"));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    @Test
    public void testCommentsAndEmptyLines() throws IOException {
        final String code = // 1
        "1,2,3,\n" + // 1b
        "\n" + // 1c
        "\n" + // 2
        "a,b x,c#no-comment\n" + // 3
        "#foo\n" + // 4
        "\n" + // 4b
        "\n" + // 5
        "d,e,#no-comment\n" + // 5b
        "\n" + // 5c
        "\n" + // 6
        "# penultimate comment\n" + // 6b
        "\n" + // 6c
        "\n" + // 7
        "# Final comment\n";
        final CSVFormat format = CSVFormat.DEFAULT.withCommentMarker('#').withIgnoreEmptyLines(false);
        assertFalse("Should not ignore empty lines", format.getIgnoreEmptyLines());
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "1"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "2"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "3"));
            // 1
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 1b
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 1c
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "b x"));
            // 2
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "c#no-comment"));
            // 3
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "foo"));
            // 4
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 4b
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "d"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "e"));
            // 5
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "#no-comment"));
            // 5b
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 5c
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 6
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "penultimate comment"));
            // 6b
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 6c
            assertThat(parser.nextToken(new Token()), matches(EORECORD, ""));
            // 7
            assertThat(parser.nextToken(new Token()), matches(COMMENT, "Final comment"));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    // simple token with escaping not enabled
    @Test
    public void testBackslashWithoutEscaping() throws IOException {
        /*
         * file: a,\,,b \,,
         */
        final String code = "a,\\,,b\\\n\\,,";
        final CSVFormat format = CSVFormat.DEFAULT;
        assertFalse(format.isEscapeCharacterSet());
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            // an unquoted single backslash is not an escape char
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "\\"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b\\"));
            // an unquoted single backslash is not an escape char
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "\\"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(EOF, ""));
        }
    }

    // simple token with escaping enabled
    @Test
    public void testBackslashWithEscaping() throws IOException {
        /*
         * file: a,\,,b \,,
         */
        final String code = "a,\\,,b\\\\\n\\,,\\\nc,d\\\r\ne";
        final CSVFormat format = formatWithEscaping.withIgnoreEmptyLines(false);
        assertTrue(format.isEscapeCharacterSet());
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ","));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b\\"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ","));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "\nc"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "d\r"));
            assertThat(parser.nextToken(new Token()), matches(EOF, "e"));
        }
    }

    // encapsulator tokenizer (single line)
    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testNextToken4() throws IOException {
        /*
         * file: a,"foo",b a, " foo",b a,"foo " ,b // whitespace after closing encapsulator a, " foo " ,b
         */
        final String code = "a,\"foo\",b\na,   \" foo\",b\na,\"foo \"  ,b\na,  \" foo \"  ,b";
        try (final Lexer parser = createLexer(code, CSVFormat.DEFAULT.withIgnoreSurroundingSpaces())) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "foo"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, " foo"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "foo "));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, " foo "));
            // assertTokenEquals(EORECORD, "b", parser.nextToken(new Token()));
            assertThat(parser.nextToken(new Token()), matches(EOF, "b"));
        }
    }

    // encapsulator tokenizer (multi line, delimiter in string)
    @Test
    public void testNextToken5() throws IOException {
        final String code = "a,\"foo\n\",b\n\"foo\n  baar ,,,\"\n\"\n\t \n\"";
        try (final Lexer parser = createLexer(code, CSVFormat.DEFAULT)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "foo\n"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "foo\n  baar ,,,"));
            assertThat(parser.nextToken(new Token()), matches(EOF, "\n\t \n"));
        }
    }

    // change delimiters, comment, encapsulater
    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testNextToken6() throws IOException {
        /*
         * file: a;'b and \' more ' !comment;;;; ;;
         */
        final String code = "a;'b and '' more\n'\n!comment;;;;\n;;";
        final CSVFormat format = CSVFormat.DEFAULT.withQuote('\'').withCommentMarker('!').withDelimiter(';');
        try (final Lexer parser = createLexer(code, format)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "a"));
            assertThat(parser.nextToken(new Token()), matches(EORECORD, "b and ' more\n"));
        }
    }

    // From CSV-1
    @Test
    public void testDelimiterIsWhitespace() throws IOException {
        final String code = "one\ttwo\t\tfour \t five\t six";
        try (final Lexer parser = createLexer(code, CSVFormat.TDF)) {
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "one"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "two"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, ""));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "four"));
            assertThat(parser.nextToken(new Token()), matches(TOKEN, "five"));
            assertThat(parser.nextToken(new Token()), matches(EOF, "six"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedCR() throws Exception {
        try (final Lexer lexer = createLexer("character\\" + CR + "Escaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + CR + "Escaped"));
        }
    }

    @Test
    public void testCR() throws Exception {
        try (final Lexer lexer = createLexer("character" + CR + "NotEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character"));
            assertThat(lexer.nextToken(new Token()), hasContent("NotEscaped"));
        }
    }

    @Test
    public void testEscapedLF() throws Exception {
        try (final Lexer lexer = createLexer("character\\" + LF + "Escaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + LF + "Escaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testLF() throws Exception {
        try (final Lexer lexer = createLexer("character" + LF + "NotEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character"));
            assertThat(lexer.nextToken(new Token()), hasContent("NotEscaped"));
        }
    }

    // TODO is this correct? Do we expect <esc>TAB to be unescaped?
    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedTab() throws Exception {
        try (final Lexer lexer = createLexer("character\\" + TAB + "Escaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + TAB + "Escaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testTab() throws Exception {
        try (final Lexer lexer = createLexer("character" + TAB + "NotEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + TAB + "NotEscaped"));
        }
    }

    // TODO is this correct? Do we expect <esc>BACKSPACE to be unescaped?
    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedBackspace() throws Exception {
        try (final Lexer lexer = createLexer("character\\" + BACKSPACE + "Escaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + BACKSPACE + "Escaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testBackspace() throws Exception {
        try (final Lexer lexer = createLexer("character" + BACKSPACE + "NotEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + BACKSPACE + "NotEscaped"));
        }
    }

    // TODO is this correct? Do we expect <esc>FF to be unescaped?
    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedFF() throws Exception {
        try (final Lexer lexer = createLexer("character\\" + FF + "Escaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + FF + "Escaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testFF() throws Exception {
        try (final Lexer lexer = createLexer("character" + FF + "NotEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + FF + "NotEscaped"));
        }
    }

    @Test
    public void testEscapedMySqlNullValue() throws Exception {
        // MySQL uses \N to symbolize null values. We have to restore this
        try (final Lexer lexer = createLexer("character\\NEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character\\NEscaped"));
        }
    }

    @Test
    public void testEscapedCharacter() throws Exception {
        try (final Lexer lexer = createLexer("character\\aEscaped", formatWithEscaping)) {
            assertThat(lexer.nextToken(new Token()), hasContent("character\\aEscaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedControlCharacter() throws Exception {
        // we are explicitly using an escape different from \ here
        try (final Lexer lexer = createLexer("character!rEscaped", CSVFormat.DEFAULT.withEscape('!'))) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + CR + "Escaped"));
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testEscapedControlCharacter2() throws Exception {
        try (final Lexer lexer = createLexer("character\\rEscaped", CSVFormat.DEFAULT.withEscape('\\'))) {
            assertThat(lexer.nextToken(new Token()), hasContent("character" + CR + "Escaped"));
        }
    }

    @Test(expected = IOException.class)
    public void testEscapingAtEOF() throws Exception {
        final String code = "escaping at EOF is evil\\";
        try (final Lexer lexer = createLexer(code, formatWithEscaping)) {
            lexer.nextToken(new Token());
        }
    }
}
