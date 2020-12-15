# b2c-vc-verifier

This is a modified version of the Verifiable Credentials verifier sample located [here](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/verifier). It is modified to be a REST API that works with Azure AD B2C so that you can integrate it with an app that is protected by Azure AD B2C.

With this sample, you can use Verifiable Credentials as a way to authenticate to B2C. You can do that in two ways:
- One way is linking a Verifiable Credential card in the Microsoft Authenticator wallet to a B2C account. In this case the subject of the JWT token that B2C issues will be the objectId of the B2C user. 
- The other way is skipping the account linking and use the VC stand alone. In this case the subject of the JWT token that B2C issues will be the VC subject. 

In order to make the Verifiable Credentials with Azure AD B2C, you need to deploy the following:

1. Deploy this node.js verifier to an Azure App Service
1. Create an Azure Storage Account and deploy the custom html
1. Deploy an Azure AD B2C instance and setting up B2C Identity Experience Framework (explained [here](https://docs.microsoft.com/en-us/azure/active-directory-b2c/custom-policy-get-started))
1. Modify and upload the B2C Custom Policies in this github repo

# Deploy the VC Verifier to Azure App Service

...follow the instructions for auto-deploy here... (coming soon)

# Deploy the custom html

- Create an Azure Storage Account and CORS enable it for your B2C tenant (explained [here](https://docs.microsoft.com/en-us/azure/active-directory-b2c/customize-ui-with-html?pivots=b2c-user-flow#2-create-an-azure-blob-storage-account))
- Edit the `selfAsserted.html` file and replace the url reference with the url for your Azure App Service deployment.
- Upload the html files

# Deploy an Azure AD B2C instance

You need an B2C tenant instance for this sample to work. The current B2C price model is free for 50K MAU per month, so the deployment will not cost anything. How to deploy a B2C tenant is explained in the documentation [here](https://docs.microsoft.com/en-us/azure/active-directory-b2c/custom-policy-get-started). Since we are going to use B2C Custom Policies, you need to configure that too.

# Modify and upload the B2C Custom Policies

- Search-and-replace all references to `yourtenant.onmicrosoft.com` with your real tenant name, for example `contosob2c.onmicrosof.com`, in all policy xml files.
- Search-and-replace all references to `yourstorageaccount.blob.core.windows.net` with your real storage account in file `TrustFrameworkExtensions.xml`. Make sure the path matches to the full path of each uploaded html document in previous section.
- Find the `login-NonInteractive` TechnicalProfile in the `TrustFrameworkExtensions.xml` file and replace the guids for the IdentityExperienceFramework and ProxyIdentityExperienceFramework applications. You need to replace it with the AppIDs (client_id's) from the registered applications in your B2C tenant.
- Upload the policies in order: `TrustFrameworkBase.xml`, `TrustFrameworkExtensions.xml` and then the rest in no particular order.