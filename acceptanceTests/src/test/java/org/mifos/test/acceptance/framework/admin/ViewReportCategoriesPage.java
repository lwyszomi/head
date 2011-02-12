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

package org.mifos.test.acceptance.framework.admin;

import org.mifos.test.acceptance.framework.MifosPage;
import org.testng.Assert;

import com.thoughtworks.selenium.Selenium;

/**
 * Represents the View Report Categories page
 *
 */
public class ViewReportCategoriesPage extends MifosPage {

    private static final String REPORT_CATEGORIES_TABLE_ID = "viewReportsCategory.table.categoryNames";
    // Category names start on the 3rd row of the Category Names table
    private static final int CATEGORY_NAMES_START_ROW = 2;
    public ViewReportCategoriesPage(Selenium selenium) {
        super(selenium);
    }

    public ViewReportCategoriesPage verifyPage() {
        super.verifyPage("ViewReportsCategory");
        return this;
    }

    public void verifyReportCategoriesExist(String[] expectedData) {
        int start = CATEGORY_NAMES_START_ROW;
        for (String expectedCellData : expectedData) {
            String actualCellData = selenium.getTable(REPORT_CATEGORIES_TABLE_ID + "." + (start++) + ".0");
            Assert.assertEquals(actualCellData, expectedCellData);
        }

    }



}
