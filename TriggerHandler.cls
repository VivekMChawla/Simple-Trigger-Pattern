/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* This class is a core component of the Simplified Trigger Pattern for Salesforce (STP).  
* 
* All trigger handler classes that implement the Simple Trigger Pattern must extend this class.  
* Please note that under normal circumstances, this class should not be modified.
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
* @version        1.1
* @created        2014-03-12
* @modified       2015-04-05
* @systemLayer    Invocation
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @changes
* v1.0            Vivek.M.Chawla@gmail.com
* 2014-03-12      Initial implementation.
*
* v1.1            Vivek.M.Chawla@gmail.com
* 2015-04-05      Added additional comments explaining how the code in this class works.  Changed
*                 the HandlerException class from public to private.  Simplified the "recursion 
*                 check" logic and added @testVisible annotations to each one. Migrated from a CC
*                 license to the MIT license.
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public virtual class TriggerHandler {
  //───────────────────────────────────────────────────────────────────────────┐
  // Initialize static booleans to track if this is the first time a specific 
  // Trigger Action has been called within the current Execution Context.  
  //───────────────────────────────────────────────────────────────────────────┘
  public   static  boolean isBeforeInsertFirstRun   = true;
  public   static  boolean isBeforeUpdateFirstRun   = true;
  public   static  boolean isBeforeDeleteFirstRun   = true;
  public   static  boolean isAfterInsertFirstRun    = true;
  public   static  boolean isAfterUpdateFirstRun    = true;
  public   static  boolean isAfterDeleteFirstRun    = true;
  public   static  boolean isAfterUndeleteFirstRun  = true;

  //───────────────────────────────────────────────────────────────────────────┐
  // If the trigger was invoked by a DML operation on more than 200 records, 
  // multiple instances of the handler class will be created within the same
  // execution context.  This attribute tracks the batch size each instance
  // works on.
  //───────────────────────────────────────────────────────────────────────────┘
  protected final integer batchSize;

  //───────────────────────────────────────────────────────────────────────────┐
  // Declare an inner class that extends Exception. This will allow us to throw
  // a custom Exception from within this Handler Class.  If presented to a user, 
  // or inspected in a debug log, this exception will appear as an exception of 
  // type "TriggerHandler.HandlerException".
  //───────────────────────────────────────────────────────────────────────────┘
  private class HandlerException extends Exception {}

  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Constructor
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  public TriggerHandler() {
    //─────────────────────────────────────────────────────────────────────────┐
    // Ensure that this handler class is being instantiated by a Trigger. If it
    // is not, then we must kill execution and throw an Exception.  The only
    // ...ahem..."exception" to this rule is if this handler class is being
    // instantiated by a test method.
    //─────────────────────────────────────────────────────────────────────────┘
    if (Trigger.isExecuting != true && Test.isRunningTest() == false) {
      throw new HandlerException('This class may only be instantiated within a Trigger-based ' 
                                +'Execution Context.');
    }
    //─────────────────────────────────────────────────────────────────────────┐
    // Initialize the batchSize instance variable with the value from the
    // Trigger.size context variable.  This allows us to track the number of
    // records in the trigger batch at the time this class was instantiated.
    //─────────────────────────────────────────────────────────────────────────┘
    batchSize = Trigger.size;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the BEFORE INSERT static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the BEFORE INSERT trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean beforeInsertHasRun() {
    if (isBeforeInsertFirstRun) {
      return isBeforeInsertFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the BEFORE UPDATE static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the BEFORE UPDATE trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean beforeUpdateHasRun() {
    if (isBeforeUpdateFirstRun) {
      return isBeforeUpdateFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the BEFORE DELETE static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the BEFORE DELETE trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean beforeDeleteHasRun() {
    if (isBeforeDeleteFirstRun) {
      return isBeforeDeleteFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the AFTER INSERT static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the AFTER INSERT trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean afterInsertHasRun() {
    if (isAfterInsertFirstRun) {
      return isAfterInsertFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the AFTER UPDATE static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the AFTER UPDATE trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean afterUpdateHasRun() {
    if (isAfterUpdateFirstRun) {
      return isAfterUpdateFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the AFTER DELETE static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the AFTER DELETE trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean afterDeleteHasRun() {
    if (isAfterDeleteFirstRun) {
      return isAfterDeleteFirstRun = false;
    }
    return true;
  }
  /**
  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
  * Checks if the AFTER UNDELETE static flag has been tripped, and trips the flag if it has not.
  * ────────────────────────────────────────────────────────────────────────────────────────────────
  * @return   boolean   Returns TRUE if the AFTER UNDELETE trigger has already run, FALSE if not.
  * ───────────────────────────────────────────────────────────────────────────────────────────────┘
  */
  @testVisible
  protected boolean afterUndeleteHasRun() {
    if (isAfterUndeleteFirstRun) {
      return isAfterUndeleteFirstRun = false;
    }
    return true;
  }
}
