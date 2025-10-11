# Microsoft Applied Skills: Secure Azure services and workloads with Microsoft Defender for Cloud regulatory compliance controls

[Applied Skills page](https://learn.microsoft.com/en-us/credentials/applied-skills/secure-azure-services-and-workloads-with-microsoft-defender-for-cloud-regulatory-compliance-controls/)

This applied skills assessment for Defender for Cloud is recommended on the [Microsoft Security Engineer credential journey](https://archcenter.blob.core.windows.net/cdn/Credentials/Credential-Journey-Security-Engineer.pdf).

The official [Microsoft Learn labs](https://github.com/MicrosoftLearning/Secure-Azure-with-Microsoft-Defender-Cloud-Compliance-Controls) for this lay out exercises to:
- Enable Defender for Cloud features
- Implement network and application security groups for VMs
- Create log analytics workspaces
- Various other Azure service and network features

The labs also build on each other. Some instructions tell you not to tear infrastructure down for this reason, but it's all [ClickOps](https://en.wiktionary.org/wiki/ClickOps).

In this repository, I will implement the labs in infrastructure-as-code frameworks. I will start with Terraform, and may add Bicep at a later time.
