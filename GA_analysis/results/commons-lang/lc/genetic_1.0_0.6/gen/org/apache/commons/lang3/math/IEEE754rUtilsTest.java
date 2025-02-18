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
package org.apache.commons.lang3.math;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import org.junit.Test;
import org.junit.Ignore;

/**
 * Unit tests {@link org.apache.commons.lang3.math.IEEE754rUtils}.
 *
 * @version $Id$
 */
public class IEEE754rUtilsTest {

    @Test
    public void testLang381() {
        assertEquals(1.2, IEEE754rUtils.min(1.2, 2.5, Double.NaN), 0.01);
        assertEquals(2.5, IEEE754rUtils.max(1.2, 2.5, Double.NaN), 0.01);
        assertTrue(Double.isNaN(IEEE754rUtils.max(Double.NaN, Double.NaN, Double.NaN)));
        assertEquals(1.2f, IEEE754rUtils.min(1.2f, 2.5f, Float.NaN), 0.01);
        assertEquals(2.5f, IEEE754rUtils.max(1.2f, 2.5f, Float.NaN), 0.01);
        assertTrue(Float.isNaN(IEEE754rUtils.max(Float.NaN, Float.NaN, Float.NaN)));
        final double[] a = new double[] { 1.2, Double.NaN, 3.7, 27.0, 42.0, Double.NaN };
        assertEquals(42.0, IEEE754rUtils.max(a), 0.01);
        assertEquals(1.2, IEEE754rUtils.min(a), 0.01);
        final double[] b = new double[] { Double.NaN, 1.2, Double.NaN, 3.7, 27.0, 42.0, Double.NaN };
        assertEquals(42.0, IEEE754rUtils.max(b), 0.01);
        assertEquals(1.2, IEEE754rUtils.min(b), 0.01);
        final float[] aF = new float[] { 1.2f, Float.NaN, 3.7f, 27.0f, 42.0f, Float.NaN };
        assertEquals(1.2f, IEEE754rUtils.min(aF), 0.01);
        assertEquals(42.0f, IEEE754rUtils.max(aF), 0.01);
        final float[] bF = new float[] { Float.NaN, 1.2f, Float.NaN, 3.7f, 27.0f, 42.0f, Float.NaN };
        assertEquals(1.2f, IEEE754rUtils.min(bF), 0.01);
        assertEquals(42.0f, IEEE754rUtils.max(bF), 0.01);
    }

    @Test
    public void testEnforceExceptions() {
        try {
            IEEE754rUtils.min((float[]) null);
            fail("IllegalArgumentException expected for null input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.min(new float[0]);
            fail("IllegalArgumentException expected for empty input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.max((float[]) null);
            fail("IllegalArgumentException expected for null input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.max(new float[0]);
            fail("IllegalArgumentException expected for empty input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.min((double[]) null);
            fail("IllegalArgumentException expected for null input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.min(new double[0]);
            fail("IllegalArgumentException expected for empty input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.max((double[]) null);
            fail("IllegalArgumentException expected for null input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
        try {
            IEEE754rUtils.max(new double[0]);
            fail("IllegalArgumentException expected for empty input");
        } catch (final IllegalArgumentException iae) {
            /* expected */
        }
    }

    @Test
    @Ignore("Redundant Test Case (identified by JSR)")
    public void testConstructorExists() {
        new IEEE754rUtils();
    }
}
