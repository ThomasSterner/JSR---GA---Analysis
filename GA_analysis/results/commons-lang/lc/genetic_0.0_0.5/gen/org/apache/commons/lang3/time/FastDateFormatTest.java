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
package org.apache.commons.lang3.time;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.Test;
import org.junit.Ignore;

/**
 * Unit tests {@link org.apache.commons.lang3.time.FastDateFormat}.
 *
 * @since 2.0
 * @version $Id$
 */
public class FastDateFormatTest {

    /*
     * Only the cache methods need to be tested here.  
     * The print methods are tested by {@link FastDateFormat_PrinterTest}
     * and the parse methods are tested by {@link FastDateFormat_ParserTest}
     */
    @Test
    public void test_getInstance() {
        final FastDateFormat format1 = FastDateFormat.getInstance();
        final FastDateFormat format2 = FastDateFormat.getInstance();
        assertSame(format1, format2);
    }

    @Test
    public void test_getInstance_String() {
        final FastDateFormat format1 = FastDateFormat.getInstance("MM/DD/yyyy");
        final FastDateFormat format2 = FastDateFormat.getInstance("MM-DD-yyyy");
        final FastDateFormat format3 = FastDateFormat.getInstance("MM-DD-yyyy");
        // -- junit 3.8 version -- assertFalse(format1 == format2);
        assertTrue(format1 != format2);
        assertSame(format2, format3);
        assertEquals("MM/DD/yyyy", format1.getPattern());
        assertEquals(TimeZone.getDefault(), format1.getTimeZone());
        assertEquals(TimeZone.getDefault(), format2.getTimeZone());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void test_getInstance_String_TimeZone() {
        final Locale realDefaultLocale = Locale.getDefault();
        final TimeZone realDefaultZone = TimeZone.getDefault();
        try {
            Locale.setDefault(Locale.US);
            TimeZone.setDefault(TimeZone.getTimeZone("America/New_York"));
            final FastDateFormat format1 = FastDateFormat.getInstance("MM/DD/yyyy", TimeZone.getTimeZone("Atlantic/Reykjavik"));
            final FastDateFormat format2 = FastDateFormat.getInstance("MM/DD/yyyy");
            final FastDateFormat format3 = FastDateFormat.getInstance("MM/DD/yyyy", TimeZone.getDefault());
            final FastDateFormat format4 = FastDateFormat.getInstance("MM/DD/yyyy", TimeZone.getDefault());
            final FastDateFormat format5 = FastDateFormat.getInstance("MM-DD-yyyy", TimeZone.getDefault());
            final FastDateFormat format6 = FastDateFormat.getInstance("MM-DD-yyyy");
            // -- junit 3.8 version -- assertFalse(format1 == format2);
            assertTrue(format1 != format2);
            assertEquals(TimeZone.getTimeZone("Atlantic/Reykjavik"), format1.getTimeZone());
            assertEquals(TimeZone.getDefault(), format2.getTimeZone());
            assertSame(format3, format4);
            // -- junit 3.8 version -- assertFalse(format3 == format5);
            assertTrue(format3 != format5);
            // -- junit 3.8 version -- assertFalse(format3 == format5);
            assertTrue(format4 != format6);
        } finally {
            Locale.setDefault(realDefaultLocale);
            TimeZone.setDefault(realDefaultZone);
        }
    }

    @Test
    public void test_getInstance_String_Locale() {
        final Locale realDefaultLocale = Locale.getDefault();
        try {
            Locale.setDefault(Locale.US);
            final FastDateFormat format1 = FastDateFormat.getInstance("MM/DD/yyyy", Locale.GERMANY);
            final FastDateFormat format2 = FastDateFormat.getInstance("MM/DD/yyyy");
            final FastDateFormat format3 = FastDateFormat.getInstance("MM/DD/yyyy", Locale.GERMANY);
            // -- junit 3.8 version -- assertFalse(format1 == format2);
            assertTrue(format1 != format2);
            assertSame(format1, format3);
            assertEquals(Locale.GERMANY, format1.getLocale());
        } finally {
            Locale.setDefault(realDefaultLocale);
        }
    }

    @Test
    public void test_changeDefault_Locale_DateInstance() {
        final Locale realDefaultLocale = Locale.getDefault();
        try {
            Locale.setDefault(Locale.US);
            final FastDateFormat format1 = FastDateFormat.getDateInstance(FastDateFormat.FULL, Locale.GERMANY);
            final FastDateFormat format2 = FastDateFormat.getDateInstance(FastDateFormat.FULL);
            Locale.setDefault(Locale.GERMANY);
            final FastDateFormat format3 = FastDateFormat.getDateInstance(FastDateFormat.FULL);
            assertSame(Locale.GERMANY, format1.getLocale());
            assertSame(Locale.US, format2.getLocale());
            assertSame(Locale.GERMANY, format3.getLocale());
            // -- junit 3.8 version -- assertFalse(format1 == format2);
            assertTrue(format1 != format2);
            assertTrue(format2 != format3);
        } finally {
            Locale.setDefault(realDefaultLocale);
        }
    }

    @Test
    public void test_changeDefault_Locale_DateTimeInstance() {
        final Locale realDefaultLocale = Locale.getDefault();
        try {
            Locale.setDefault(Locale.US);
            final FastDateFormat format1 = FastDateFormat.getDateTimeInstance(FastDateFormat.FULL, FastDateFormat.FULL, Locale.GERMANY);
            final FastDateFormat format2 = FastDateFormat.getDateTimeInstance(FastDateFormat.FULL, FastDateFormat.FULL);
            Locale.setDefault(Locale.GERMANY);
            final FastDateFormat format3 = FastDateFormat.getDateTimeInstance(FastDateFormat.FULL, FastDateFormat.FULL);
            assertSame(Locale.GERMANY, format1.getLocale());
            assertSame(Locale.US, format2.getLocale());
            assertSame(Locale.GERMANY, format3.getLocale());
            // -- junit 3.8 version -- assertFalse(format1 == format2);
            assertTrue(format1 != format2);
            assertTrue(format2 != format3);
        } finally {
            Locale.setDefault(realDefaultLocale);
        }
    }

    @Test
    public void test_getInstance_String_TimeZone_Locale() {
        final Locale realDefaultLocale = Locale.getDefault();
        final TimeZone realDefaultZone = TimeZone.getDefault();
        try {
            Locale.setDefault(Locale.US);
            TimeZone.setDefault(TimeZone.getTimeZone("America/New_York"));
            final FastDateFormat format1 = FastDateFormat.getInstance("MM/DD/yyyy", TimeZone.getTimeZone("Atlantic/Reykjavik"), Locale.GERMANY);
            final FastDateFormat format2 = FastDateFormat.getInstance("MM/DD/yyyy", Locale.GERMANY);
            final FastDateFormat format3 = FastDateFormat.getInstance("MM/DD/yyyy", TimeZone.getDefault(), Locale.GERMANY);
            // -- junit 3.8 version -- assertNotSame(format1, format2);
            assertTrue(format1 != format2);
            assertEquals(TimeZone.getTimeZone("Atlantic/Reykjavik"), format1.getTimeZone());
            assertEquals(TimeZone.getDefault(), format2.getTimeZone());
            assertEquals(TimeZone.getDefault(), format3.getTimeZone());
            assertEquals(Locale.GERMANY, format1.getLocale());
            assertEquals(Locale.GERMANY, format2.getLocale());
            assertEquals(Locale.GERMANY, format3.getLocale());
        } finally {
            Locale.setDefault(realDefaultLocale);
            TimeZone.setDefault(realDefaultZone);
        }
    }

    @Test
    public void testCheckDefaults() {
        final FastDateFormat format = FastDateFormat.getInstance();
        final FastDateFormat medium = FastDateFormat.getDateTimeInstance(FastDateFormat.SHORT, FastDateFormat.SHORT);
        assertEquals(medium, format);
        final SimpleDateFormat sdf = new SimpleDateFormat();
        assertEquals(sdf.toPattern(), format.getPattern());
        assertEquals(Locale.getDefault(), format.getLocale());
        assertEquals(TimeZone.getDefault(), format.getTimeZone());
    }

    @Test
    public void testCheckDifferingStyles() {
        final FastDateFormat shortShort = FastDateFormat.getDateTimeInstance(FastDateFormat.SHORT, FastDateFormat.SHORT, Locale.US);
        final FastDateFormat shortLong = FastDateFormat.getDateTimeInstance(FastDateFormat.SHORT, FastDateFormat.LONG, Locale.US);
        final FastDateFormat longShort = FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.SHORT, Locale.US);
        final FastDateFormat longLong = FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.LONG, Locale.US);
        assertFalse(shortShort.equals(shortLong));
        assertFalse(shortShort.equals(longShort));
        assertFalse(shortShort.equals(longLong));
        assertFalse(shortLong.equals(longShort));
        assertFalse(shortLong.equals(longLong));
        assertFalse(longShort.equals(longLong));
    }

    @Test
    public void testDateDefaults() {
        assertEquals(FastDateFormat.getDateInstance(FastDateFormat.LONG, Locale.CANADA), FastDateFormat.getDateInstance(FastDateFormat.LONG, TimeZone.getDefault(), Locale.CANADA));
        assertEquals(FastDateFormat.getDateInstance(FastDateFormat.LONG, TimeZone.getTimeZone("America/New_York")), FastDateFormat.getDateInstance(FastDateFormat.LONG, TimeZone.getTimeZone("America/New_York"), Locale.getDefault()));
        assertEquals(FastDateFormat.getDateInstance(FastDateFormat.LONG), FastDateFormat.getDateInstance(FastDateFormat.LONG, TimeZone.getDefault(), Locale.getDefault()));
    }

    @Test
    public void testTimeDefaults() {
        assertEquals(FastDateFormat.getTimeInstance(FastDateFormat.LONG, Locale.CANADA), FastDateFormat.getTimeInstance(FastDateFormat.LONG, TimeZone.getDefault(), Locale.CANADA));
        assertEquals(FastDateFormat.getTimeInstance(FastDateFormat.LONG, TimeZone.getTimeZone("America/New_York")), FastDateFormat.getTimeInstance(FastDateFormat.LONG, TimeZone.getTimeZone("America/New_York"), Locale.getDefault()));
        assertEquals(FastDateFormat.getTimeInstance(FastDateFormat.LONG), FastDateFormat.getTimeInstance(FastDateFormat.LONG, TimeZone.getDefault(), Locale.getDefault()));
    }

    @Test
    public void testTimeDateDefaults() {
        assertEquals(FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM, Locale.CANADA), FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM, TimeZone.getDefault(), Locale.CANADA));
        assertEquals(FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM, TimeZone.getTimeZone("America/New_York")), FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM, TimeZone.getTimeZone("America/New_York"), Locale.getDefault()));
        assertEquals(FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM), FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.MEDIUM, TimeZone.getDefault(), Locale.getDefault()));
    }

    /**
     * According to LANG-954 (https://issues.apache.org/jira/browse/LANG-954) this is broken in Android 2.1.
     */
    @Test
    public void testLang954() {
        final String pattern = "yyyy-MM-dd'T'";
        FastDateFormat.getInstance(pattern);
    }

    @Test
    public void testParseSync() throws InterruptedException {
        final String pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS Z";
        final FastDateFormat formatter = FastDateFormat.getInstance(pattern);
        final long sdfTime = measureTime(formatter, new SimpleDateFormat(pattern) {

            // because SimpleDateFormat is serializable
            private static final long serialVersionUID = 1L;

            @Override
            public Object parseObject(final String formattedDate) throws ParseException {
                synchronized (this) {
                    return super.parse(formattedDate);
                }
            }
        });
        final long fdfTime = measureTime(formatter, FastDateFormat.getInstance(pattern));
        final String times = ">>FastDateFormatTest: FastDateParser:" + fdfTime + "  SimpleDateFormat:" + sdfTime;
        System.out.println(times);
    }

    final static private int NTHREADS = 10;

    final static private int NROUNDS = 10000;

    private long measureTime(final Format formatter, final Format parser) throws InterruptedException {
        final ExecutorService pool = Executors.newFixedThreadPool(NTHREADS);
        final AtomicInteger failures = new AtomicInteger(0);
        final AtomicLong totalElapsed = new AtomicLong(0);
        for (int i = 0; i < NTHREADS; ++i) {
            pool.submit(new Runnable() {

                @Override
                public void run() {
                    for (int j = 0; j < NROUNDS; ++j) {
                        try {
                            final Date date = new Date();
                            final String formattedDate = formatter.format(date);
                            final long start = System.currentTimeMillis();
                            final Object pd = parser.parseObject(formattedDate);
                            totalElapsed.addAndGet(System.currentTimeMillis() - start);
                            if (!date.equals(pd)) {
                                failures.incrementAndGet();
                            }
                        } catch (final Exception e) {
                            failures.incrementAndGet();
                            e.printStackTrace();
                        }
                    }
                }
            });
        }
        pool.shutdown();
        // depending on the performance of the machine used to run the parsing,
        // the tests can run for a while. It should however complete within
        // 30 seconds. Might need increase on very slow machines.
        if (!pool.awaitTermination(30, TimeUnit.SECONDS)) {
            pool.shutdownNow();
            fail("did not complete tasks");
        }
        assertEquals(0, failures.get());
        return totalElapsed.get();
    }
}
