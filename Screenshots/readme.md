# How-To Guide Title

_The purpose of this document is to serve as a guide on how to granularly enable Defender for Server Plan 2 on a Resource (Per-Machine)   Level_

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

_Initially, Microsoft only provided the ability to  enable Defender For Cloud Server Plans at a Subscription level only. 
Subsequently, Microsoft has introduced “some” additional Deployment options documented here : Decide on Deployment Scope . 
Microsoft specifically calls out some noteworthy statements in the deployment scope options URL mentioned above :
1.	 “Plan 2 can't be enabled at the resource level, but you can disable the plan at the resource level.”
2.	“Turn off a plan for specific machines”. “Regardless of whether a plan is turned on or off in a subscription, you can turn off a plan for a specific machine.” 
This makes it possible to Disable Plan 2 explicitly on a resource level ( Machines ), while Enabling Plan 2 on a Subscription Level. The subscription level configuration will not be Inherited  by  resources ( Machines ) that have been configured to Explicitly Disable Plan2. 
This allows customers the ability to granularly apply Defender for Server Plan 2 , by using Azure Tags and Defender for Servers activation on resource level script 
_

## Prerequisites

_List any requirements, tools, or knowledge needed before starting._

## Step 1: Description of Step 1

_Detailed instructions for the first step._

## Step 2: Description of Step 2

_Detailed instructions for the second step._

## Step 3: Description of Step 3

_Detailed instructions for the third step._

## Troubleshooting

_Common issues and how to resolve them._

## FAQ

_Frequently asked questions and answers._

## References

_Links or resources for further reading._