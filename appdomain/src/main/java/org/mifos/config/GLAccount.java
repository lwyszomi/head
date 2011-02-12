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

package org.mifos.config;

import org.mifos.accounts.financial.business.GLCategoryType;

/**
 * Lightweight value type for general ledger accounts. Top-level general ledger
 * accounts are also known as categories.
 * <p>
 * Users of this class should ensure that {@link #glCode} and {@link #name} are
 * never null.
 */
public class GLAccount {
    /**
     * A series of (usually) numbers unique to this general ledger account.
     * Should never be null, empty, or less than one character. If so, this
     * object is in an illegal state.
     */
    public String glCode;

    /**
     * A name describing this general ledger account. Should never be null,
     * empty, or less than one character. If so, this object is in an illegal
     * state.
     * <p>
     * Does this name have to be unique?
     */
    public String name;

    /**
     * General ledger code of parent account. May be null. If so, this GL
     * account is a top-level account (also known as a category).
     */
    public String parentGlCode;

    /**
     * Top-level accounts (also called categories) will have a non-null value
     * for this field.
     */
    public GLCategoryType categoryType;

    /**
     * Slightly simplified since we assume {@link #glCode} and {@link #name} are
     * never null (a requirement for users of this class). The
     * <code>equals</code> method generated by an IDE like Eclipse is arguably
     * more generic, predictable, recognizable and maintainable; but this
     * handwritten version works, too.
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || !(obj instanceof GLAccount)) {
            return false;
        }

        GLAccount other = (GLAccount) obj;
        if (other.glCode.equals(glCode) && other.name.equals(name)
                && (null == other.parentGlCode ? null == parentGlCode : other.parentGlCode.equals(parentGlCode))) {
            return true;
        }

        return false;
    }

    /**
     * Slightly simplified since we assume {@link #glCode} and {@link #name} are
     * never null (a requirement for users of this class). The
     * <code>hashCode</code> method generated by an IDE like Eclipse is arguably
     * more generic, predictable, recognizable and maintainable; but this
     * handwritten version works, too.
     */
    @Override
    public int hashCode() {
        return glCode.hashCode() + name.hashCode() + (null == parentGlCode ? 0 : parentGlCode.hashCode());
    }

    @Override
    public String toString() {
        return "code=" + glCode + " name=" + name + " parent=" + parentGlCode;
    }
}
