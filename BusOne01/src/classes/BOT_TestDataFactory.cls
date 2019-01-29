/*
Name            : BOT_TestDataFactory
Created By      : Sreenivasulu A
Created Date    : 15-OCT-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is a test data factory class and used to create the records for test classes.
*/
@isTest
public class BOT_TestDataFactory 
{
    //To create Account records
    public void createAccountRecords(Integer noOfAccounts, String Channel)
    {
        List<Account> lstAccount;       //To create a list of Account records
        Integer i = 0;
        
        //To avoid duplication of Entity Ids start the Entity Id from 1000
        if(Channel == 'Specialty Provider')
        {
            i = i + 1000;
            noOfAccounts = noOfAccounts + 1000;
        }
        //To avoid duplication of Entity Ids start the Entity Id from 2000
        else if(Channel == 'PBM')
        {
            i = i + 2000;
            noOfAccounts = noOfAccounts + 2000;
        }

        //Creating a list of Parent Account records
        lstAccount = new List<Account>();
        for(; i < noOfAccounts; i++)
        {
            lstAccount.add(new Account(Name = 'Test Parent Account '+ i, BOT_Entity_ID__c = i, Account_Type__c = Channel, BOT_Entity_Level__c = 'National', BOT_Is_BOT_Data__c = true));            
        }
        insert lstAccount;
    }
    
    //To create Account records with Specialty Provider channel
    public void createSpecialtyProviderAccountRecords(Integer noOfAccounts)
    {
        List<Account> lstAccount;       //To create a list of Specialty provider Account records
        Integer i;
        
        //Creating a list of Specilaty provider Account records
        lstAccount = new List<Account>();
        for(i = 0; i < noOfAccounts; i++)
        {
            lstAccount.add(new Account(Name = 'Test Specialty Provider Account '+ i, BOT_Entity_ID__c = i + 1000, Account_Type__c = 'Specialty Provider'));
        }
        insert lstAccount;
    }
    
   //To create Person Account records
    public void createPersonAccountRecords(Integer noOfPersonAccounts)
    {
        List<Account> lstAccount;       //To create a list of PersonAccount records
        Integer i;
        
        //Creating a list of Person Account records
        lstAccount = new List<Account>();
        noOfPersonAccounts = noOfPersonAccounts + 1000;
        for(i = 1000; i < noOfPersonAccounts; i++)
        {
            lstAccount.add(new Account(Name = 'Test Person Account '+ i, BOT_Entity_ID__c = i, Account_Type__c = 'PersonAccount', BOT_Is_BOT_Data__c = true));            
        }
        insert lstAccount;
    }
    
    //To create Child Account records
    public void createChildAccountRecords(Integer noOfAccounts, Integer noOfPersonAccounts)
    {
        List<Child_Account_vod__c> lstChildAccount;     //To create a list of Child Accounts
        Integer i, j;
        
        //Creating a list of Person Account records
        lstChildAccount = new List<Child_Account_vod__c>();
        noOfPersonAccounts = noOfPersonAccounts + 1000;
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 1000; j < noOfPersonAccounts; j++)
            {
                lstChildAccount.add(new Child_Account_vod__c(BOT_Entity_ID__c = i, BOT_Personnel_ID__c = j));   
            }
        }
        insert lstChildAccount;
    }
    
    //To create Benefit Design records
    public void createBenefitDesignRecords(Integer noOfAccounts, Integer noOfBenefitDesign, String Channel)
    {
        system.debug('***Calling this method***');
        List<Benefit_Design_vod__c> lstBenefitDesign;
        Benefit_Design_vod__c objBenefitDesign;
        Integer i, j, temp = 0;
        
        lstBenefitDesign = new List<Benefit_Design_vod__c>();
        if(Channel == 'Employer')
        {
            for(i = 0; i < noOfAccounts; i++)
            {
                for(j = 0; j < noOfBenefitDesign; j++)
                {
                    objBenefitDesign = new Benefit_Design_vod__c();
                    objBenefitDesign.BOT_Entity_ID__c = i;
                    //objBenefitDesign.External_ID_vod__c = String.valueOf(temp);
                    objBenefitDesign.BOT_Benefit_Design_ID__c = temp;
                    objBenefitDesign.BOT_Formulary_Name__c = 'BOT Test Formulary Name '+ temp;
                    objBenefitDesign.Type_vod__c = channel;
                    objBenefitDesign.BOT_Is_BOT_Data__c = true;
                    
                    if(j==1)
                    {
                         objBenefitDesign.Lives_vod__c=null;   
                    }
                    else
                    {
                        objBenefitDesign.Lives_vod__c=998+j;   
                    }
                   
                    lstBenefitDesign.add(objBenefitDesign);  
                    temp++;
                }
            }
        }
        else
        {
            for(i = 0; i < noOfAccounts; i++)
            {
                for(j = 0; j < noOfBenefitDesign; j++)
                {
                    objBenefitDesign = new Benefit_Design_vod__c();
                    objBenefitDesign.BOT_Entity_ID__c = i;
                    //objBenefitDesign.External_ID_vod__c = String.valueOf(temp);
                    objBenefitDesign.BOT_Benefit_Design_ID__c = temp;
                    objBenefitDesign.BOT_Formulary_Name__c = 'BOT Test Formulary Name where name is morethan 80 Characters BOT Test Formulary Name 2';
                    objBenefitDesign.Type_vod__c = channel;
                    objBenefitDesign.BOT_Is_BOT_Data__c = true;
                    //objBenefitDesign.Lives_vod__c=999+j;
                    if(j==0)
                    {
                         objBenefitDesign.Lives_vod__c=null;   
                    }
                    else
                    {
                        objBenefitDesign.Lives_vod__c=998+j;   
                    }
                    lstBenefitDesign.add(objBenefitDesign);  
                    temp++;
                }
            }    
        }                
        insert lstBenefitDesign;
    }
    
    //To create Benefit Design record with out BOT Entity Id
    public List<Benefit_Design_vod__c> benefitDesignRecordsWithoutEntityID(Integer noOfAccounts, Integer noOfBenefitDesign)
    {
        List<Benefit_Design_vod__c> lstBenefitDesign;
        Benefit_Design_vod__c objBenefitDesign;
        Integer i, j, temp = 0;
        
        lstBenefitDesign = new List<Benefit_Design_vod__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfBenefitDesign; j++)
            {
                objBenefitDesign = new Benefit_Design_vod__c();
                //objBenefitDesign.BOT_Entity_ID__c = i;
                //objBenefitDesign.External_ID_vod__c = String.valueOf(temp);
                objBenefitDesign.BOT_Benefit_Design_ID__c = temp;
                objBenefitDesign.BOT_Formulary_Name__c = 'BOT Test Formulary Name '+ temp;
                //objBenefitDesign.Type_vod__c = channel;
                objBenefitDesign.BOT_Is_BOT_Data__c = true;
                lstBenefitDesign.add(objBenefitDesign);  
                temp++;
            }
        }                
        //insert lstBenefitDesign;
        return lstBenefitDesign;
    }
    
    //To create formulary product records
    public void createFormularyProductRecords(Integer noOfFormularyProducts)
    {
        List<Formulary_Products_vod__c> lstFormularyProduct;    //To create list of Formulary product records
        Formulary_Products_vod__c objFormularyProduct;          //To create a formulary product record
        Integer i;
        
        lstFormularyProduct = new List<Formulary_Products_vod__c>();
        for(i = 0; i < noOfFormularyProducts; i++)
        {
            objFormularyProduct = new Formulary_Products_vod__c();
            objFormularyProduct.Name = 'Test Drug '+i;
            objFormularyProduct.Market_vod__c = 'Test Market '+ i;
            //objFormularyProduct.external_Id_vod__c = String.valueOf(i);
            objFormularyProduct.BOT_Formulary_Product_ID__c = i;
            objFormularyProduct.BOT_Is_BOT_Data__c = true;
            lstFormularyProduct.add(objFormularyProduct);
        }
        insert lstFormularyProduct;
    }

    //To create test data for BOT_AccountTriggerHandlerTest
    //To create Account records with affiliates
    public List<Account> createAccountsWithParentId(Integer noOfParentAccounts, Integer noOfChildAccounts, String Channel)
    {
        List<Account> lstAccount;       //To create a list of Account records
        Integer i, j, temp = 1000;
        
        //Creating a list of Affiliate Account records
        lstAccount = new List<Account>();
        for(i = 0; i < noOfParentAccounts; i++)
        {
            for(j = 0; j < noOfChildAccounts; j++)
            {
                lstAccount.add(new Account(Name = 'Test Affiliate Account '+ temp, BOT_Entity_ID__c = temp, Account_Type__c = Channel, 
                                           BOT_Entity_Level__c = 'Regional', BOT_Parent_Entity_ID__c = i, BOT_Is_BOT_Data__c = true));   
                temp++;
            }
        }
        //insert lstAccount;        
        return lstAccount;
    }
    
    //To create test data for BOT_AddressTriggerHandlerTest
    //To create Address records with Account Ids
    public void createAddressRecords(Integer noOfAccounts, Integer noOfAddress)
    {
        List<Address_vod__c> lstAddress;    //To create a list of Address records
        Address_vod__c objAddress;          //To create an address record
        Integer i, j;
        
        //Creating a list of Address records
        lstAddress = new List<Address_vod__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfAddress; j++)
            {
                objAddress = new Address_vod__c();
                objAddress.Name = 'Test Address Line '+ i + j;
                objAddress.Address_line_2_vod__c = 'Test Address Line 2';
                objAddress.BOT_Entity_ID__c = i;
                objAddress.City_vod__c = 'Test city';
                objAddress.Phone_vod__c = '1234567890';
                lstAddress.add(objAddress);
            }
        }
        insert lstAddress;
        //upsert lstAddress;
    }
    
    //To create test data for BOT_PlanProductTriggerHandlerTest
    //To create plan product records with related account
    public void createPlanProductRecords(Integer noOfAccounts, Integer noOfPlanProducts, String Channel)
    {
        List<BOT_Plan_Product__c> lstPlanProduct;   //To create a list of Plan product records
        BOT_Plan_Product__c objPlanProduct;         //To create a Plan product record
        Integer i, j, temp;
        
        if(Channel == 'Employer')
        {
            lstPlanProduct = new List<BOT_Plan_Product__c>();
            temp = 0;
            for(i = 0; i < noOfAccounts; i++)
            {
                for(j = 0; j < noOfPlanProducts; j++)
                {
                    objPlanProduct = new BOT_Plan_Product__c();
                    objPlanProduct.BOT_Entity_ID__c = i;
                    objPlanProduct.BOT_Medical_Admin_ID__c = i;
                    objPlanProduct.BOT_Product_Name__c = 'BOT Test Product Name '+ temp;
                    objPlanProduct.BOT_Channel__c = Channel;
                    objPlanProduct.BOT_Product_ID__c = temp;
                    lstPlanProduct.add(objPlanProduct);
                    temp++;
                }
            }
            insert lstPlanProduct;
        }
        else
        {
            lstPlanProduct = new List<BOT_Plan_Product__c>();
            temp = 0;
            for(i = 0; i < noOfAccounts; i++)
            {
                for(j = 0; j < noOfPlanProducts; j++)
                {
                    objPlanProduct = new BOT_Plan_Product__c();
                    objPlanProduct.BOT_Entity_ID__c = i;
                    objPlanProduct.BOT_Product_Name__c = 'BOT Test Product Name Where product name is having more than 80 characters are here '+ temp;
                    objPlanProduct.BOT_Product_ID__c = temp;
                    lstPlanProduct.add(objPlanProduct);
                    temp++;
                }
            }
            insert lstPlanProduct;
        }        
    }
    
    //To create plan product records without Entity ID
    public void createPlanProductWithoutEntityID(Integer noOfAccounts, Integer noOfPlanProducts)
    {
        List<BOT_Plan_Product__c> lstPlanProduct;   //To create a list of Plan product records
        BOT_Plan_Product__c objPlanProduct;         //To create a Plan product record
        Integer i, j, temp;
        
        lstPlanProduct = new List<BOT_Plan_Product__c>();
        temp = 0;
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfPlanProducts; j++)
            {
                objPlanProduct = new BOT_Plan_Product__c();
                //objPlanProduct.BOT_Entity_ID__c = i;
                objPlanProduct.BOT_Medical_Admin_ID__c = i;
                objPlanProduct.BOT_Product_Name__c = 'BOT Test Product Name '+ temp;
                objPlanProduct.BOT_Product_ID__c = temp;
                lstPlanProduct.add(objPlanProduct);
                temp++;
            }
        }
        insert lstPlanProduct;
    }    
    
    //To create test data for BOT_BenefitDesignLineTriggerHandlerTest
    //To create Benefit design Line records with related Benefit design Id and Formulary Product Id
    public List<Benefit_Design_Line_vod__c> createBenefitDesignLineRecords(Integer noOfBenefitDesigns, Integer noOfFormularyProducts)
    {
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;  //To create list of Benefit design line records
        Benefit_Design_Line_vod__c objBenefitDesignLine;        //To create a Benefit desig record
        integer i, j;
        
        //Creating a list of benefit design line records
        lstBenefitDesignLine = new List<Benefit_Design_Line_vod__c>();
        for(i = 0; i < noOfBenefitDesigns; i++)
        {
            for(j = 0; j < noOfFormularyProducts; j++)
            {
                objBenefitDesignLine = new Benefit_Design_Line_vod__c();
                objBenefitDesignLine.BOT_Benefit_Design_ID__c = i;
                objBenefitDesignLine.BOT_Formulary_Product_ID__c = j;
                objBenefitDesignLine.Status_Source_vod__c = 'Test Status 1';
                objBenefitDesignLine.Restrictions_Source_vod__c = 'PA';
                objBenefitDesignLine.Notes_Source_vod__c = 'Test Notes';
                objBenefitDesignLine.Copay_Source_vod__c = '$10 - $20';
                objBenefitDesignLine.BOT_Is_BOT_Data__c = true;
                lstBenefitDesignLine.add(objBenefitDesignLine);
            }
        }
        return lstBenefitDesignLine;
        //insert lstBenefitDesignLine;
    }
    
    //To create test data for BOT_BenefitDesignLineTriggerHandlerTest
    //To create Benefit design Line records without related Formulary Product Id
    public List<Benefit_Design_Line_vod__c> benefitDesignLineWithoutFormularyProductId(Integer noOfParentsReccords, Integer noOfBenefitDesignLine)
    {
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;  //To create list of Benefit design line records
        Benefit_Design_Line_vod__c objBenefitDesignLine;        //To create a Benefit desig record
        integer i, j;
        
        //Creating a list of benefit design line records
        lstBenefitDesignLine = new List<Benefit_Design_Line_vod__c>();
        for(i = 0; i < noOfParentsReccords; i++)
        {
            for(j = 0; j < noOfBenefitDesignLine; j++)
            {
                objBenefitDesignLine = new Benefit_Design_Line_vod__c();
                objBenefitDesignLine.BOT_Benefit_Design_ID__c = i;
                //objBenefitDesignLine.BOT_Formulary_Product_ID__c = i;
                objBenefitDesignLine.Status_Source_vod__c = 'Test Status 1';
                objBenefitDesignLine.Restrictions_Source_vod__c = 'PA';
                objBenefitDesignLine.Notes_Source_vod__c = 'Test Notes';
                objBenefitDesignLine.Copay_Source_vod__c = '$10 - $20';
                objBenefitDesignLine.BOT_Is_BOT_Data__c = true;
                lstBenefitDesignLine.add(objBenefitDesignLine);
            }
        }
        return lstBenefitDesignLine;
        //insert lstBenefitDesignLine;
    }
    
    //To create test data for BOT_PharmacyServicesHandlerTest class
    //To create Pharmacy Service records with related account
    public void createPharmacyServices(Integer noOfAccounts, Integer noOfPharmacyServices)
    {
        List<BOT_Pharmacy_Service__c> lstPharmacyService = new List<BOT_Pharmacy_Service__c>(); //To create list of pharmacy service records
        BOT_Pharmacy_Service__c objPharmacyService;                                             //To create a pharmacy service record
        Integer i, j;
        
        //Creating a list of Pharmacy Services
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfPharmacyServices; j++)
            {
                objPharmacyService = new BOT_Pharmacy_Service__c();
                objPharmacyService.BOT_SubChannel__c = 'Commercial';
                objPharmacyService.BOT_Entity_ID__c = i;
                objPharmacyService.BOT_PBM_ID__c = i + 2000;
                objPharmacyService.Name = 'Formulary development/Admin';
                lstPharmacyService.add(objPharmacyService);
            }
        }
        insert lstPharmacyService;
    }
    
    //To create Pharmacy Service records without Entity Id
    public void createPharmacyServicesWithoutEntityID(Integer noOfAccounts, Integer noOfPharmacyServices)
    {
        List<BOT_Pharmacy_Service__c> lstPharmacyService = new List<BOT_Pharmacy_Service__c>(); //To create list of pharmacy service records
        BOT_Pharmacy_Service__c objPharmacyService;                                             //To create a pharmacy service record
        Integer i, j;
        
        //Creating a list of Pharmacy Services
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfPharmacyServices; j++)
            {
                objPharmacyService = new BOT_Pharmacy_Service__c();
                objPharmacyService.BOT_SubChannel__c = 'Commercial';
                //objPharmacyService.BOT_Entity_ID__c = i;
                objPharmacyService.BOT_PBM_ID__c = i + 1000;
                objPharmacyService.Name = 'Formulary development/Admin';
                lstPharmacyService.add(objPharmacyService);
            }
        }
        insert lstPharmacyService;
    }
    
    //To create test data for BOT_TheraClassTriggerHandlerTest
    //To create Thera class records with parent Specialty provider Id
    public void createTheraClassWithSpecialtyId(Integer noOfSpecialtyProviders, Integer noOfTheraClass)
    {
        List<BOT_Thera_Class__c> lstTheraClass; //To create a list of Thera class records
        integer i, j;
        
        //Creating a list of Thera class records
        lstTheraClass = new List<BOT_Thera_Class__c>();
        for(i = 1000; i < noOfSpecialtyProviders + 1000; i++)           //Specialty provider Entity Ids starts from 1000
        {
            for(j = 0; j < noOfTheraClass; j++)
            {
                lstTheraClass.add(new BOT_Thera_Class__c(BOT_Thera_Name__c = 'Test Thera ' + i + j, BOT_Specialty_Provider_ID__c = i));
            }
        }
        insert lstTheraClass;
    }
    
    //To create Thera class records without Specialty provider Id
    public void createTheraClassWithoutSpecialtyId(Integer noOfSpecialtyProviders, Integer noOfTheraClass)
    {
        List<BOT_Thera_Class__c> lstTheraClass; //To create a list of Thera class records
        integer i, j;
        
        //Creating a list of Thera class records
        lstTheraClass = new List<BOT_Thera_Class__c>();
        for(i = 1000; i < noOfSpecialtyProviders + 1000; i++)           //Specialty provider Entity Ids starts from 1000
        {
            for(j = 0; j < noOfTheraClass; j++)
            {
                lstTheraClass.add(new BOT_Thera_Class__c(BOT_Thera_Name__c = 'Test Thera ' + i + j));
            }
        }
        insert lstTheraClass;
    }
    
    //To create test data for BOT_SPPJoTriggerHandlerTest
    //To create a list of Specialty providers and Account to Specialty provider linking records
    public void createSPPToAccountRecords(Integer noOfAccounts, Integer noOfSpecialtyproviders)
    {
        List<Account> lstAccount;                                   //To create a list of Specialty provider Account records
        List<BOT_Specialty_Provider_JO__c> lstSpecialtyProviderJO;  //To create a list of Junction object records
        BOT_Specialty_Provider_JO__c objSpecialtyProviderJO;        //To create a Junction object record
        Integer i, j, temp = 1000;
        
        //Creating a list of juntion object records
        lstSpecialtyProviderJO = new List<BOT_Specialty_Provider_JO__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfAccounts; j++)
            {
                objSpecialtyProviderJO = new BOT_Specialty_Provider_JO__c();
                objSpecialtyProviderJO.BOT_Entity_ID__c = i;
                objSpecialtyProviderJO.BOT_Specialty_Provider_ID__c = j + 1000;
                lstSpecialtyProviderJO.add(objSpecialtyProviderJO);
            }
        }
        insert lstSpecialtyProviderJO;
    }
    
    //To create a list of Account to Specialty provider records without Entity ID
    public void createSPPToAccountWithoutEntityID(Integer noOfAccounts, Integer noOfSpecialtyproviders)
    {
        List<Account> lstAccount;                                   //To create a list of Specialty provider Account records
        List<BOT_Specialty_Provider_JO__c> lstSpecialtyProviderJO;  //To create a list of Junction object records
        BOT_Specialty_Provider_JO__c objSpecialtyProviderJO;        //To create a Junction object record
        Integer i, j, temp = 1000;
        
        //Creating a list of juntion object records
        lstSpecialtyProviderJO = new List<BOT_Specialty_Provider_JO__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfAccounts; j++)
            {
                objSpecialtyProviderJO = new BOT_Specialty_Provider_JO__c();
                //objSpecialtyProviderJO.BOT_Entity_ID__c = i;
                objSpecialtyProviderJO.BOT_Specialty_Provider_ID__c = j + 1000;
                lstSpecialtyProviderJO.add(objSpecialtyProviderJO);
            }
        }
        insert lstSpecialtyProviderJO;
    }
    
    //To create test data for BOT_DrugAccessTriggerHandlerTest
    //To create a list of Drug access records
    public List<BOT_Drug_Access__c> createDrugAccessRecords(Integer noOfAccounts, Integer noOfFormualryProducts)
    {
        List<BOT_Drug_Access__c> lstDrugAccess;                 //To create a list of drug access records
        BOT_Drug_Access__c objDrugAccess;                       //To create a drug Access record
        Integer i, j;
        
        //Creating a list of Drug access records
        lstDrugAccess = new List<BOT_Drug_Access__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfFormualryProducts; j++)
            {
                objDrugAccess = new BOT_Drug_Access__c();
                objDrugAccess.BOT_Entity_ID__c = i;
                objDrugAccess.BOT_Formulary_Product_ID__c = j;
                objDrugAccess.BOT_Total_Plan_Rx_Lives__c = j + 10000;
                objDrugAccess.BOT_Formulary_Drug_Rx_Lives__c = j + 1000;
                objDrugAccess.BOT_Access_Percentage__c = j + 90;
                objDrugAccess.BOT_Drug_Status__c = 'PA';
                lstDrugAccess.add(objDrugAccess);    
            }
        }
        //insert lstDrugAccess;
        return lstDrugAccess;
    }
    
    //To create a list of Drug access records without Entity ID
    public List<BOT_Drug_Access__c> createDrugAccessWithoutEntityID(Integer noOfAccounts, Integer noOfFormualryProducts)
    {
        List<BOT_Drug_Access__c> lstDrugAccess;                 //To create a list of drug access records
        BOT_Drug_Access__c objDrugAccess;                       //To create a drug Access record
        Integer i, j;
        
        //Creating a list of Drug access records
        lstDrugAccess = new List<BOT_Drug_Access__c>();
        for(i = 0; i < noOfAccounts; i++)
        {
            for(j = 0; j < noOfFormualryProducts; j++)
            {
                objDrugAccess = new BOT_Drug_Access__c();
                //objDrugAccess.BOT_Entity_ID__c = i;
                objDrugAccess.BOT_Formulary_Product_ID__c = j;
                objDrugAccess.BOT_Total_Plan_Rx_Lives__c = j + 10000;
                objDrugAccess.BOT_Formulary_Drug_Rx_Lives__c = j + 1000;
                objDrugAccess.BOT_Access_Percentage__c = j + 90;
                objDrugAccess.BOT_Drug_Status__c = 'PA';
                lstDrugAccess.add(objDrugAccess);    
            }
        }
        //insert lstDrugAccess;
        return lstDrugAccess;
    }
    
    //To create test data for BOT_ProductFormularyTriggerHandlerTest
    //To create a list of Product Formulary records
    public List<BOT_Product_Formulary_JO__c> createProductFormularyRecords(Integer noOfParentsReccords, Integer noOfProductFormularyRecords)
    {
        List<BOT_Product_Formulary_JO__c> lstProductFormulary;  //To create a list of Product formulary records
        BOT_Product_Formulary_JO__c objProductFormulary;        //To create a product formulary record
        integer i, j;
        
        //Creating a list of Product Formaulary records
        lstProductFormulary = new List<BOT_Product_Formulary_JO__c>();
        for(i = 0; i < noOfParentsReccords; i++)
        {
            for(j = 0; j < noOfProductFormularyRecords; j++)
            {
                objProductFormulary = new BOT_Product_Formulary_JO__c();
                objProductFormulary.BOT_Plan_Product_ID__c = i;
                objProductFormulary.BOT_Benefit_Design_ID__c = j;
                //objProductFormulary.BOT_Total_Formulary_Lives__c = 1000;
                lstProductFormulary.add(objProductFormulary);
            }
        }
        //insert lstProductFormulary;
        return lstProductFormulary;
    }
    
    //To create a list of Product Formulary records without product ID
    public List<BOT_Product_Formulary_JO__c> createProductFormularyWithoutProductId(Integer noOfParentsReccords, Integer noOfProductFormularyRecords)
    {
        List<BOT_Product_Formulary_JO__c> lstProductFormulary;  //To create a list of Product formulary records
        BOT_Product_Formulary_JO__c objProductFormulary;        //To create a product formulary record
        integer i, j;
        
        //Creating a list of Product Formaulary records
        lstProductFormulary = new List<BOT_Product_Formulary_JO__c>();
        for(i = 0; i < noOfParentsReccords; i++)
        {
            for(j = 0; j < noOfProductFormularyRecords; j++)
            {
                objProductFormulary = new BOT_Product_Formulary_JO__c();
                //objProductFormulary.BOT_Plan_Product_ID__c = i;
                objProductFormulary.BOT_Benefit_Design_ID__c = j;
                //objProductFormulary.BOT_Total_Formulary_Lives__c = 1000;
                lstProductFormulary.add(objProductFormulary);
            }
        }
        //insert lstProductFormulary;
        return lstProductFormulary;
    }
    
    //To create a list of Account plan records
    public List<Account_Plan_vod__c> createAccountPlanRecords(Id accountId, Integer noOfAccountPlanRecords)
    {
        List<Account_Plan_vod__c> lstAccountPlans = new List<Account_Plan_vod__c>();
        for(Integer i = 0; i < noOfAccountPlanRecords; i++)
        {
            lstAccountPlans.add(new Account_Plan_vod__c(Name = 'Test Account Plan '+ i, Account_vod__c = accountId, Type__c = 'National'));    
        }
        return lstAccountPlans;
    }
    
    //To create a list of Account plan records
    public List<BOT_Coverage_Policy__c> createCoveragePolicyRecords(Id accountId, Integer noOfCoveragePolicyRecords)
    {
        List<BOT_Coverage_Policy__c> lstCoveragePolicy = new List<BOT_Coverage_Policy__c>();
        BOT_Coverage_Policy__c objCoveragePolicy;
        
        for(Integer i = 0; i < noOfCoveragePolicyRecords; i++)
        {
            objCoveragePolicy = new BOT_Coverage_Policy__c();
            //objCoveragePolicy.BOT_Entity_ID__c = i;
            objCoveragePolicy.BOT_Account__c = accountId;
            objCoveragePolicy.Name = 'Test Policy ' + i;
            objCoveragePolicy.BOT_Channel__c = 'Commercial';
            objCoveragePolicy.BOT_Drug__c = 'Test Drug ' + i;
            objCoveragePolicy.BOT_Market__c = 'Immunology';
            objCoveragePolicy.BOT_Score__c = 'Test Score ' + i;
            objCoveragePolicy.BOT_Indication__c = 'Test Indication ' + i;
            objCoveragePolicy.BOT_Sub_Indication__c = 'Test Sub Indication ' + i;
            lstCoveragePolicy.add(objCoveragePolicy);
        }
        return lstCoveragePolicy;
    }
}