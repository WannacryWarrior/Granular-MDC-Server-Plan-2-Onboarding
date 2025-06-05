# Granular Defender for Cloud - Server Plan 2 Onboarding

_The purpose of this document is to serve as a guide on how to granularly enable Server - Plan 2 on a Resource (Per-Machine)   Level for a given Azure subsciption_ This is usefull for a POC or Pilot Phase. 

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Step 1: Description of Step 1](#step-1-description-of-step-1)
4. [Step 2: Description of Step 2](#step-2-description-of-step-2)
5. [Step 3: Description of Step 3](#step-3-description-of-step-3)
6. [Troubleshooting](#troubleshooting)
7. [FAQ](#faq)
8. [References](#references)

---
## Introduction

Initially, Microsoft  provided the ability to Enable the Defender For Cloud Server Plans at Subscription level only, which takes an "all or nothing approach to Workload protection for Machines within a given subscription.
Subsequently, Microsoft has introduced “some” additional Deployment options documented here : [Decide on Deployment Scope](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-defender-for-servers-select-plan#decide-on-deployment-scope) . 

Microsoft specifically calls out some noteworthy statements in the deployment scope options URL mentioned above :

- **“Plan 2 can't be enabled at the resource level, but you can disable the plan at the resource level.”**

- **“Turn off a plan for specific machines”. “Regardless of whether a plan is turned on or off in a subscription, you can turn off a plan for a specific machine.”**
 
This makes it possible to Disable Plan 2 explicitly on a resource level (/*Machines), while Enabling Plan 2 on a Subscription Level. 

The subscription level configuration will not be Inherited  by  resources ( Machines ) that have been configured to Explicitly Disable Plan 2.

This allows customers the ability to **Granularly apply Server - Plan 2 ,** by using :

- [Azure Tags](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources) 

- [Defender for Servers activation on resource level script](https://github.com/Azure/Microsoft-Defender-for-Cloud/blob/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level/ResourceLevelPricingAtScale.ps1)
- Azure Policy [_Configure Azure Defender for Servers to be disabled for resources (resource level) with the selected tag_](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F080fedce-9d4a-4d07-abf0-9f036afbc9c8) **Not covered in this Guide!**


## Prerequisites

- [Defender for Servers activation on resource level script](https://github.com/Azure/Microsoft-Defender-for-Cloud/blob/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level/ResourceLevelPricingAtScale.ps1)
- [AZVM_Tagger.ps1]()


## Step 1: Apply Tags to All Resources (VM/ARC/VMSS) in a Subscription

1. Download,execute and authenicate [AZVM_Tagger.ps1]() :
![Screenshot:AzVM_Tagger.ps1 Logon](Screenshots/Picture1.png)

2. The Script will prompt for a *Subscription ID*. Supply the Subscription ID where your Machines are located. The script will then output all Resources found in the subscription :
![Screenshot:AzVM_Tagger.ps1 Logon](Screenshots/Picture10.png)

3. The script will prompt for the _Tag Name_ , and _tag value_ : I used the below values :
 Name : **_MDC Server Plan 2_**  
 Value : **_Disabled_**  
![Screenshot:AzVM_Tagger.ps1 Logon](Screenshots/Picture14.png)  

4. Confirm the machines in subscription are tagged.

## Step 2: Apply "Disable Defender for Cloud Server plans" Config for all servers with the Tag ( created in step 1 )

1. Run the [Defender for Servers activation on resource level script](https://github.com/Azure/Microsoft-Defender-for-Cloud/blob/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level/ResourceLevelPricingAtScale.ps1) and authenicate if prompted. 

2. The script will then ask you to Supply a **_Subscription ID_** , use the same Subscription ID that was used in step 1.2 and press Enter.
![Screenshot:ResourceLevelPricingAtScale.ps1 - Subscription ID](Screenshots/Picture15.png)
3. The script will now ask which Mode to use for Targetting, type **_TAG_** ,and press Enter ( We want to apply the config using the tags )  
4. The script will now ask for the Tag Name and Tag Value. **_Supply the values that was used in step 1.3_** and press Enter.
![ResourceLevelPricingAtScale.ps1 - Tag Mode ](Screenshots/Picture16.png)
4. As per the above screenshot, The script will return the servers found with the Tag Name and Values supplied in the previous step. **_Review and confirm the Machines_** in the list and then press any key to continue.
5. The script will now move to Configuration mode, where it will prompt you to provide the configuration option for the servers in scope, specify **"Free"** and press Enter.  (This option will explicitly define "MDC Server Plan - Disabled").
![ResourceLevelPricingAtScale.ps1 - Tag Mode ](Screenshots/Picture17.png)

(Once the above steps are complete, you have explicitly set  Defender for Cloud server Plans, to Disabled, on the Resource Level, for all Machines in the supplied Subscription ID **This overrides ANY Defender for Cloud Server Plan settings defined on the subscription level**.)

## Step 3: Enable Server - Plan 2 on the Subscription 

For the Subscription that was supplied in Step 1 and Step 2 , follow the enablement steps outlined here : [Deploy Defender for Servers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-on-azure-aws-or-gcp)

## Step 4: Update the Tag Value from "Disabled" to "Enabled" for the Machines that require Server - Plan 2 

You can use a powershell script or Rest API call to automate this, for the sake of simplicity the modification was performed using the Portal : 

![Azure Portal - Update Tag](Screenshots/Picture18.png)

## Step 5: Update the Tag Value from "Disabled" to "Enabled" for the Machines that require Server - Plan 2 

1. Once again, run the [Defender for Servers activation on resource level script](https://github.com/Azure/Microsoft-Defender-for-Cloud/blob/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level/ResourceLevelPricingAtScale.ps1) and authenicate if prompted. 

2. Again, the script will then ask you to Supply a **_Subscription ID_** , use the same Subscription ID that was used in step 1.2 and press Enter.
![Screenshot:ResourceLevelPricingAtScale.ps1 - Subscription ID](Screenshots/Picture15.png)
3. The script will now ask which Mode to use for Targetting, type **_TAG_** ,and press Enter 

4. Again, the script will now ask for the Tag Name and Tag Value. Supply the same **_Tag Name_** that was defined in step 1.3.  
This Time , when the script prompts for a **Tag Value , supply the new Value : "Enabled"**
![ResourceLevelPricingAtScale.ps1 - Tag Mode ](Screenshots/Picture20.png)
4. Again, as per the above screenshot, The script will return the servers found with the Tag Name and Value's supplied in the previous step. Review and confirm the Machines in the list and then press any key to continue. Confirm that the machines in the output are the machines were Server - Plan 2 needs to be enabled, and press any key to proceed  
5. The script will now move to Configuration mode, where it will prompt you to provide the configuration option for the servers in scope, specify **_"Delete"_** and press Enter.  
( This option will Delete any explicitly defined configuration and the Machine will inherit configuration from the subscription" ).
![ResourceLevelPricingAtScale.ps1 - Tag Mode ](Screenshots/Picture21.png)

## Step 6: Validate Granular onboarding 

If steps 1 - 5 were followed the **MDE.windows extension should be provisioned to all machines** in the subscription with the Tag value set to "Enabled" :
![Portal - Conifirm  MDE.Windows Extension ](Screenshots/Picture22.png)


## Troubleshooting

_Common issues and how to resolve them._

## FAQ

_Frequently asked questions and answers._

## References

[Select a Defender for Servers plan - Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-defender-for-servers-select-plan#decide-on-deployment-scope)  
[Deploy Defender for Servers in Microsoft Defender for Cloud - Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-defender-for-servers-at-the-resource-level)  
[Microsoft-Defender-for-Cloud/Powershell scripts/Defender for Servers on resource level at main · Azure/Microsoft-Defender-for-Cloud · GitHub](https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Powershell%20scripts/Defender%20for%20Servers%20on%20resource%20level)  
[Use tags to organize your Azure resources and management hierarchy - Azure Resource Manager](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources)  
[Deploy Defender for Servers in Microsoft Defender for Cloud - Microsoft Defender for Cloud ](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#disable-defender-for-servers-on-a-subscription)
