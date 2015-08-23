/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* Test class for the TriggerHandler virtual class, core component of the Simple Trigger Pattern for 
* Salesforce (STP).
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* Copyright (c) 2015 Vivek M. Chawla (@VivekMChawla)
*
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
* associated documentation files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge, publish, distribute,
* sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all copies or
* substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
* NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
* DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Vivek M. Chawla     <Vivek.M.Chawla@gmail.com>
* @modifiedBy     Vivek M. Chawla     <Vivek.M.Chawla@gmail.com>
* @maintainedBy   Vivek M. Chawla     <Vivek.M.Chawla@gmail.com>
* @version        1.0
* @created        2015-08-16
* @modified       2015-08-16
* @systemLayer    Test
* @see            TriggerHandler.class
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @changes
* v1.0            Vivek.M.Chawla@gmail.com
* 2015-08-16      Initial implementation.
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
@isTest
private class TriggerHandlerTest {
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Use one test method to ensure that all "recursion check" methods properly flip their answers
  * from FALSE, to TRUE, and that they remain TRUE for at least one more method call after detecting
  * the flip.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  static testMethod void recursionCheckMethods_NormalOperation_Success() {
    //─────────────────────────────────────────────────────────────────────────┐
    // Instantiate a TriggerHandler parent class, then test all of the 
    // "recursion check" methods.
    //─────────────────────────────────────────────────────────────────────────┘
    TriggerHandler handler = new TriggerHandler();

    //─────────────────────────────────────────────────────────────────────────┐
    // Before Insert.
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.beforeInsertHasRun());
    System.AssertEquals(true,   handler.beforeInsertHasRun());
    System.AssertEquals(true,   handler.beforeInsertHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // Before Update.
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.beforeUpdateHasRun());
    System.AssertEquals(true,   handler.beforeUpdateHasRun());
    System.AssertEquals(true,   handler.beforeUpdateHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // Before Delete.
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.beforeDeleteHasRun());
    System.AssertEquals(true,   handler.beforeDeleteHasRun());
    System.AssertEquals(true,   handler.beforeDeleteHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // After Insert.
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.afterInsertHasRun());
    System.AssertEquals(true,   handler.afterInsertHasRun());
    System.AssertEquals(true,   handler.afterInsertHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // After Update.
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.afterUpdateHasRun());
    System.AssertEquals(true,   handler.afterUpdateHasRun());
    System.AssertEquals(true,   handler.afterUpdateHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // After Delete
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.afterDeleteHasRun());
    System.AssertEquals(true,   handler.afterDeleteHasRun());
    System.AssertEquals(true,   handler.afterDeleteHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // After Undelete
    //─────────────────────────────────────────────────────────────────────────┘
    System.AssertEquals(false,  handler.afterUndeleteHasRun());
    System.AssertEquals(true,   handler.afterUndeleteHasRun());
    System.AssertEquals(true,   handler.afterUndeleteHasRun());

    //─────────────────────────────────────────────────────────────────────────┐
    // All done.
    //─────────────────────────────────────────────────────────────────────────┘
    return;

  }
}
