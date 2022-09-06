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
package org.apache.commons.io.input;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.Ignore;

/**
 * Test for the SwappedDataInputStream. This also
 * effectively tests the underlying EndianUtils Stream methods.
 */
public class SwappedDataInputStreamTest {

    private SwappedDataInputStream sdis;

    private byte[] bytes;

    @Before
    public void setUp() {
        bytes = new byte[] { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
        final ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        this.sdis = new SwappedDataInputStream(bais);
    }

    @After
    public void tearDown() {
        this.sdis = null;
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadBoolean() throws IOException {
        bytes = new byte[] { 0x00, 0x01, 0x02 };
        final ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        final SwappedDataInputStream sdis = new SwappedDataInputStream(bais);
        assertEquals(false, sdis.readBoolean());
        assertEquals(true, sdis.readBoolean());
        assertEquals(true, sdis.readBoolean());
        sdis.close();
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadByte() throws IOException {
        assertEquals(0x01, this.sdis.readByte());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadChar() throws IOException {
        assertEquals((char) 0x0201, this.sdis.readChar());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadDouble() throws IOException {
        assertEquals(Double.longBitsToDouble(0x0807060504030201L), this.sdis.readDouble(), 0);
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadFloat() throws IOException {
        assertEquals(Float.intBitsToFloat(0x04030201), this.sdis.readFloat(), 0);
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadFully() throws IOException {
        final byte[] bytesIn = new byte[8];
        this.sdis.readFully(bytesIn);
        for (int i = 0; i < 8; i++) {
            assertEquals(bytes[i], bytesIn[i]);
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadInt() throws IOException {
        assertEquals(0x04030201, this.sdis.readInt());
    }

    @Test(expected = UnsupportedOperationException.class)
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadLine() throws IOException {
        this.sdis.readLine();
        fail("readLine should be unsupported. ");
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadLong() throws IOException {
        assertEquals(0x0807060504030201L, this.sdis.readLong());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadShort() throws IOException {
        assertEquals((short) 0x0201, this.sdis.readShort());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadUnsignedByte() throws IOException {
        assertEquals(0x01, this.sdis.readUnsignedByte());
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadUnsignedShort() throws IOException {
        assertEquals((short) 0x0201, this.sdis.readUnsignedShort());
    }

    @Test(expected = UnsupportedOperationException.class)
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testReadUTF() throws IOException {
        this.sdis.readUTF();
        fail("readUTF should be unsupported. ");
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testSkipBytes() throws IOException {
        this.sdis.skipBytes(4);
        assertEquals(0x08070605, this.sdis.readInt());
    }
}
