/*
 * The MIT License
 *
 * Copyright 2014 Piotr Baran <admin@piotrus.net.pl>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.projects.discussion.helper;

import java.text.Normalizer;

public class Slug {
    public static String parse(String input) {
        if (input == null || input.length() == 0) {
            return "";
        }
        String out = normalize(input);
        out = removeDuplicateWhiteSpaces(out);
        out = out.toLowerCase().replace(" ", "_");
 
        return out;
    }
 
    private static String normalize(String input) {
        String result = Normalizer.normalize(input, Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
        result = result.replaceAll("[^a-zA-Z0-9\\s]", " ");
 
        return result;
    }
 
    private static String removeDuplicateWhiteSpaces(String input) {
        return input.replaceAll("\\s+", " ");
    }
}
