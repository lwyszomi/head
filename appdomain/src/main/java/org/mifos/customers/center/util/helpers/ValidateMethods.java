/*
 * Copyright Grameen Foundation USA
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */

package org.mifos.customers.center.util.helpers;

/**
 * This class contains methods which can be used to validate certain fields.
 * Contsins methods to check if a particuar value is either null or blank
 */
public class ValidateMethods {

    /***
     * This method checks if a particuar value is either null or blank
     *
     * @param value
     *            the value that has to be checked as to whether it is null or
     *            blank
     * @return True or false as to whether the value passed was null or blank
     */
    public static boolean isNullOrBlank(String value) {
        boolean isValueNull = false;

        if (value == null || value.trim().equals(CenterConstants.BLANK)) {
            isValueNull = true;
        }
        return isValueNull;
    }

}
