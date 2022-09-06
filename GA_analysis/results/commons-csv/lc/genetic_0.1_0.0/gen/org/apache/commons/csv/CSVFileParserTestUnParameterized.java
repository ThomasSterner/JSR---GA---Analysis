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

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import java.io.*;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import static org.junit.Assert.*;
import org.junit.Ignore;

/**
 * Parse tests using test files
 */
public class CSVFileParserTestUnParameterized {

    private static final String BASE_DIR = "src/test/resources/CSVFileParser";

    private static final File BASE = new File(BASE_DIR);

    private String testName;

    private String readTestData(BufferedReader testData, String testName) throws IOException {
        this.testName = testName;
        String line;
        do {
            line = testData.readLine();
        } while (line != null && line.startsWith("#"));
        return line;
    }

    @Parameters
    public static Collection<Object[]> generateData() {
        final List<Object[]> list = new ArrayList<>();
        final FilenameFilter fileNameFilter = new FilenameFilter() {

            @Override
            public boolean accept(final File dir, final String name) {
                return name.startsWith("test") && name.endsWith(".txt");
            }
        };
        final File[] files = BASE.listFiles(fileNameFilter);
        if (files != null) {
            for (final File f : files) {
                list.add(new Object[] { f });
            }
        }
        return list;
    }

    @Test
    public void testCSVFile0() throws Exception {
        this.testCSVFile("test_default.txt");
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testCSVUrl0() throws Exception {
        this.testCSVUrl("test_default.txt");
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testCSVFile1() throws Exception {
        this.testCSVFile("test_default_comment.txt");
    }

    @Test
    public void testCSVUrl1() throws Exception {
        this.testCSVUrl("test_default_comment.txt");
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testCSVFile2() throws Exception {
        this.testCSVFile("test_rfc4180.txt");
    }

    @Test
    public void testCSVUrl2() throws Exception {
        this.testCSVUrl("test_rfc4180.txt");
    }

    @Test
    public void testCSVFile3() throws Exception {
        this.testCSVFile("test_rfc4180_trim.txt");
    }

    @Test
    public void testCSVUrl3() throws Exception {
        this.testCSVUrl("test_rfc4180_trim.txt");
    }

    @Test
    public void testCSVFile4() throws Exception {
        this.testCSVFile("testCSV85_default.txt");
    }

    @Test
    public void testCSVUrl4() throws Exception {
        this.testCSVUrl("testCSV85_default.txt");
    }

    @Test
    public void testCSVFile5() throws Exception {
        this.testCSVFile("testCSV85_ignoreEmpty.txt");
    }

    @Test
    public void testCSVUrl5() throws Exception {
        this.testCSVUrl("testCSV85_ignoreEmpty.txt");
    }

    public void testCSVFile(String fileName) throws Exception {
        final File file = Paths.get(BASE_DIR, fileName).toFile();
        final BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = readTestData(reader, file.getName());
        assertNotNull("file must contain config line", line);
        final String[] split = line.split(" ");
        assertTrue(testName + " require 1 param", split.length >= 1);
        // first line starts with csv data file name
        CSVFormat format = CSVFormat.newFormat(',').withQuote('"');
        boolean checkComments = false;
        for (int i = 1; i < split.length; i++) {
            final String option = split[i];
            final String[] option_parts = option.split("=", 2);
            if ("IgnoreEmpty".equalsIgnoreCase(option_parts[0])) {
                format = format.withIgnoreEmptyLines(Boolean.parseBoolean(option_parts[1]));
            } else if ("IgnoreSpaces".equalsIgnoreCase(option_parts[0])) {
                format = format.withIgnoreSurroundingSpaces(Boolean.parseBoolean(option_parts[1]));
            } else if ("CommentStart".equalsIgnoreCase(option_parts[0])) {
                format = format.withCommentMarker(option_parts[1].charAt(0));
            } else if ("CheckComments".equalsIgnoreCase(option_parts[0])) {
                checkComments = true;
            } else {
                fail(testName + " unexpected option: " + option);
            }
        }
        // get string version of format
        line = readTestData(reader, file.getName());
        assertEquals(testName + " Expected format ", line, format.toString());
        // Now parse the file and compare against the expected results
        // We use a buffered reader internally so no need to create one here.
        try (final CSVParser parser = CSVParser.parse(new File(BASE, split[0]), Charset.defaultCharset(), format)) {
            for (final CSVRecord record : parser) {
                String parsed = Arrays.toString(record.values());
                if (checkComments) {
                    final String comment = record.getComment().replace("\n", "\\n");
                    if (comment != null) {
                        parsed += "#" + comment;
                    }
                }
                final int count = record.size();
                assertEquals(testName, readTestData(reader, file.getName()), count + ":" + parsed);
            }
        }
    }

    public void testCSVUrl(String fileName) throws Exception {
        final File file = Paths.get(BASE_DIR, fileName).toFile();
        final BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = readTestData(reader, file.getName());
        assertNotNull("file must contain config line", line);
        final String[] split = line.split(" ");
        assertTrue(testName + " require 1 param", split.length >= 1);
        // first line starts with csv data file name
        CSVFormat format = CSVFormat.newFormat(',').withQuote('"');
        boolean checkComments = false;
        for (int i = 1; i < split.length; i++) {
            final String option = split[i];
            final String[] option_parts = option.split("=", 2);
            if ("IgnoreEmpty".equalsIgnoreCase(option_parts[0])) {
                format = format.withIgnoreEmptyLines(Boolean.parseBoolean(option_parts[1]));
            } else if ("IgnoreSpaces".equalsIgnoreCase(option_parts[0])) {
                format = format.withIgnoreSurroundingSpaces(Boolean.parseBoolean(option_parts[1]));
            } else if ("CommentStart".equalsIgnoreCase(option_parts[0])) {
                format = format.withCommentMarker(option_parts[1].charAt(0));
            } else if ("CheckComments".equalsIgnoreCase(option_parts[0])) {
                checkComments = true;
            } else {
                fail(testName + " unexpected option: " + option);
            }
        }
        // get string version of format
        line = readTestData(reader, file.getName());
        assertEquals(testName + " Expected format ", line, format.toString());
        // Now parse the file and compare against the expected results
        final URL resource = ClassLoader.getSystemResource("CSVFileParser/" + split[0]);
        try (final CSVParser parser = CSVParser.parse(resource, Charset.forName("UTF-8"), format)) {
            for (final CSVRecord record : parser) {
                String parsed = Arrays.toString(record.values());
                if (checkComments) {
                    final String comment = record.getComment().replace("\n", "\\n");
                    if (comment != null) {
                        parsed += "#" + comment;
                    }
                }
                final int count = record.size();
                assertEquals(testName, readTestData(reader, file.getName()), count + ":" + parsed);
            }
        }
    }
}
