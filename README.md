##Introduction

This is the official public repository of the Simple Trigger Pattern for Salesforce (STP).  This pattern was developed by Salesforce MVP Vivek M. Chawla ([@VivekMChawla](https://twitter.com/VivekMChawla)), a Salesforce Certified Platform Developer (Levels I and II), App Builder, and Advanced Administrator.

The Simple Trigger Pattern can be used to quick-start development of new triggers. It encapsulates several best-practices, including "One Trigger per Object", "No Business Logic in Triggers", and "Recursion Prevention Using Static Variables".  The STP also facilitates adoption of the architectural best practice of Separation of Concerns.

**NOTE:** If you are looking for the Gist "snippet collection" of Simple Trigger Pattern files, you can find it here: [bit.ly/SimpleTriggerPatternGist](http://bit.ly/SimpleTriggerPatternGist)

##Contents

The following files are contained in this repository:

- **LICENSE.txt** 
  - Copyright and license information
  - All code and documentation are distributed under MIT License
  - If you find this pattern useful, let me know [@VivekMChawla](https://twitter.com/VivekMChawla)
- **README.md**
  - The file you're reading right now
- **TriggerHandler.cls**
  - Apex virtual class
  - Core component of the Simple Trigger Pattern
  - Must be deployed to your org before implementing STP
  - Does __not__ require customization before deployment
  - All trigger handlers implementing STP must extend this class
- **TriggerHandlerTest.cls**
  - Apex test class
  - Must be deployed to your org before implementing STP
  - Does __not__ require customization before deployment
  - Provides 97% code coverage of the TriggerHandler virtual class
- **SampleObjectTrigger.cls**
  - Apex trigger template
  - Requires customization before deploying to your org
- **SampleObjectTriggerHandler.cls**
  - Apex class template
  - Requires customization before deploying to your org
- **SampleObjectTriggerHandlerTest.cls**
  - Apex test class template
  - Requires customization before deploying to your org

## Implementation Instructions

Additional content TBA
