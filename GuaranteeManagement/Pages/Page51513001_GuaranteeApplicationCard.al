page 51513001 "Guarantee Application Card"
{
    PageType = Card;
    SourceTable = "Guarantee Application";
    Caption = 'Guarantee Application Card';
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Documents,Approve,Request Approval,Navigate,Applicant';

    layout
    {
        area(Content)
        {
            group(General)

            {
                field("No."; "No.")
                {


                }
                field(Source; Source)
                {

                }
                field("Repeating Client"; "Repeating Client")
                {

                }
                field("Customer No."; "Customer No.")
                {
                    Enabled = "Repeating Client";

                    trigger OnValidate()
                    var
                        Customer: Record Customer;
                        Contract: Record "Guarantee Contracts";
                        CONF_CUSTOMER: TextConst ENU = 'Is this the same as current customer %1 (%2)?', ENG = 'Is this the same as current customer %1 (%2)?';
                    begin

                        if Customer.get("Customer No.") then begin
                            Contract.RESET;
                            Contract.SETRANGE("Customer No.", Customer."No.");
                            IF Contract.FINDLAST THEN begin
                                "Business Ownership Type" := Contract."Business Ownership Type";
                                Name := Contract.Name;
                                "BDS/BDO" := Contract."BDS/BDO";
                                Ownership := Contract.Ownership;
                                Customer.SETCURRENTKEY("Search Name");
                                "Any Existing Loans" := TRUE;
                                Address := Contract.Address;
                                City := Contract.City;
                                "Address 2" := Contract."Address 2";
                                "Phone No." := Contract."Phone No.";
                                "Post Code" := Contract."Post Code";
                                "Fax No." := Contract."Fax No.";
                                Gender := Contract.Gender;
                                "Date of Birth" := Contract."Date of Birth";
                                "E-Mail" := Contract."E-Mail";
                                "Home Page" := Contract."Home Page";
                                "Global Dimension 1 Code" := Contract."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := Contract."Global Dimension 2 Code";
                                "Customer TIN" := Contract."Customer TIN";
                                "Customer VRN" := Contract."Customer VRN";

                            end;
                        end;
                    end;
                }
                field("Application Date"; "Application Date")
                {

                    ShowMandatory = true;
                }
                field(Name; Name)
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        Customer: Record Customer;
                        Contract: Record "Guarantee Contracts";
                        CONF_CUSTOMER: TextConst ENU = 'Is this the same as current customer %1 (%2)?', ENG = 'Is this the same as current customer %1 (%2)?';
                    begin
                        IF (Name <> '') and ("Customer No." = '') and (Source = Source::Office) THEN BEGIN

                            Customer.SETCURRENTKEY("Search Name");
                            Customer.SETRANGE("Search Name", UPPERCASE(Name), UPPERCASE(Name) + 'zz');
                            IF Customer.FIND('-') THEN
                                IF CONFIRM(CONF_CUSTOMER, true, Customer.Name, Customer."No.") THEN BEGIN
                                    VALIDATE("Customer No.", Customer."No.");
                                    "Repeating Client" := true;
                                END;

                        END;
                    end;

                }
                field("Customer TIN"; "Customer TIN")
                {

                }
                field("Customer VRN"; "Customer VRN")
                {

                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    //Visible = false;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    //Visible = false;
                    ShowMandatory = true;
                }
                field("Global Dimension 3 Code"; "Global Dimension 3 Code")
                {
                    Visible = false;
                    ShowMandatory = true;
                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                    Visible = false;
                    ShowMandatory = true;
                }
                field("Product Type"; "Product Type")
                {

                }
                field(Product; Product)
                {
                    ShowMandatory = true;
                    trigger Onvalidate()
                    var
                        ProdCode: Record Products;
                    begin
                        if ProdCode.get(Product) then begin
                            if "Product Type" = "Product Type"::"Lenders Option" then begin

                                Portfolio := true;
                                Traditional := false;
                            end else begin
                                Portfolio := false;
                                Traditional := true;
                            end;
                        end;

                    end;

                }
                field("Type of Facility"; "Type of Facility")
                {
                    ShowMandatory = true;
                }
                field("Business Ownership Type"; "Business Ownership Type")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Ownership = Ownership::Individual then begin
                            FieldsVisibility := true;
                            ShareHoldersVisibility := false;
                        end else begin
                            ShareHoldersVisibility := true;
                            Gender := Gender::" ";
                            FieldsVisibility := false;
                            "Date of Birth" := 0D;
                        END;
                    end;
                }
                field(Gender; Gender)
                {
                    ShowMandatory = true;

                    Enabled = FieldsVisibility;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ShowMandatory = true;
                    Enabled = FieldsVisibility;
                }
                field(Age; Age)
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Application Status"; "Application Status")
                {
                    Editable = false
                    ;
                }
                field("Any Existing Loans"; "Any Existing Loans")
                {

                }
                field("BDS/BDO"; "BDS/BDO")
                {
                    ShowMandatory = true;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    ShowMandatory = true;
                }
                field("Loan Amount(LCY)"; "Loan Amount(LCY)")
                {
                    Editable = false;

                }
                field("Currency Code"; "Currency Code")
                {

                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Application Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                }
                field("Date Created"; "Date Created")
                {
                    Editable = false;
                }
            }
            group(Project)
            {
                Caption = 'Project Details';
                field("Project Description"; "Project Description")
                {
                    ShowMandatory = true;
                    MultiLine = true;
                }
                group(Employments)
                {
                    Caption = 'Employment and Beneficiaries';
                    group(Permanent)
                    {
                        Caption = 'Permanent Employments Created';
                        field("No. of Female Employees(Per)"; "No. of Female Employees(Per)")
                        {

                        }
                        field("No. of Male Employees(Per)"; "No. of Male Employees(Per)")
                        {

                        }
                    }
                    group(Casual)
                    {
                        Caption = 'Casual Employments Created';
                        field("No. of Female Employees(Cas)"; "No. of Female Employees(Cas)")
                        {

                        }
                        field("No. of Male Employees(Cas)"; "No. of Male Employees(Cas)")
                        {

                        }
                    }

                    field("No of Employments Created"; "No of Employments Created")
                    {
                        Enabled = Portfolio;
                        ShowMandatory = true;
                    }
                    group(Beneficiaries)
                    {
                        Caption = 'Beneficiaries';
                        field("No. of Male Beneficiaries"; "No. of Male Beneficiaries")
                        {

                        }
                        field("No. of Female Beneficiaries"; "No. of Female Beneficiaries")
                        {

                        }
                    }

                    field("Total No. of Beneficiaries"; "Total No. of Beneficiaries")
                    {

                    }
                }

            }
            group("CGC Information")
            {
                Visible = "Charge fees on Guaranteed Amt";
                field("Pct. Guarantee Applied"; "Pct. Guarantee Applied")
                {
                    ShowMandatory = true;

                }
                field("Applied Guarantee Amount"; "Applied Guarantee Amount")
                {
                    ShowMandatory = true;
                }
            }
            group(Addresses)
            {
                Caption = 'Address & Contact';
                field(Address; Address)
                {

                    ShowMandatory = true;
                }
                field("Address 2"; "Address 2")
                {


                }
                field(City; City)
                {

                    ShowMandatory = true;
                }
                field("Post Code"; "Post Code")
                {


                }
                field("Country/Region Code"; "Country/Region Code")
                {


                }
                field("Phone No."; "Phone No.")
                {


                }
                field("Fax No."; "Fax No.")
                {

                }
                field("E-Mail"; "E-Mail")
                {


                }
                field("Home Page"; "Home Page")
                {


                }




            }
            part(Subsctor; "Subsector & Line of Business")
            {
                Caption = 'Subsector & Line of Business';
                SubPageLink = "Client No." = field("No.");
            }
            part("FinancialInformation"; "Guarantee App Financial Info")
            {
                Visible = Traditional;
                Caption = 'Financial Information';
                SubPageLink = "Application No." = field("No.");
            }
            part(Attachment; "Required Documents")
            {
                Visible = false;

                Caption = 'Attachments';
                SubPageLink = "No." = field("No.");
            }
            group("Bank Detals")
            {
                Visible = portfolio;
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {
                    Caption = 'Bank Acc. No.';
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {

                }
                field("Receivables Acc. Name"; "Receivables Acc. Name")
                {
                    Caption = 'Bank Acc. Name';
                }
                field("Receivables Address"; "Receivables Address")
                {
                    Caption = 'Bank Address';
                }
                field("Receivables Address 2"; "Receivables Address 2")
                {
                    Caption = 'Bank Address 2';
                }
                field("Receivables Contact No."; "Receivables Contact No.")
                {
                    Caption = 'Bank Contact No.';
                }
                field("Receivables Email Address"; "Receivables Email Address")
                {
                    Caption = 'Email Address';
                }
                field("Bank Contact Person"; "Bank Contact Person")
                {
                    Caption = 'Contact Person';
                }
                field("Bank Account No"; "Bank Account No")
                {

                }

            }
            group(AppDetails)
            {
                Caption = 'App Details';

                field(AppID; AppID)
                {

                }
                field(IMEI; IMEI)
                {

                }
                field(TimeStp; TimeStp)
                {

                }
                field("Client Signature"; "Client Signature")
                {

                }
            }



        }
        area(FactBoxes)
        {

            part("Attached Documents"; "Document Attachment Factbox")
            {
                SubPageLink = "Table ID" = CONST(51513000), "No." = FIELD("No.");
            }

            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

            }
        }

    }



    actions
    {
        area(Navigation)
        {

            group(Applicant)
            {
                Caption = 'Applicant';
                action("Group Memmbers")
                {
                    Caption = 'Group Memmbers';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = page "Group Memmbers";
                    RunPageLink = "No." = field("No.");
                }
                action(Shareholders)
                {
                    Visible = ShareHoldersVisibility;
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = page "Campany Shareholders";
                    RunPageLink = "No." = field("No.");
                }
                action("Fee Waiver Aapplication")
                {
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Caption = 'Fee Waiver Aapplication';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "Fee Waiver Application";
                    RunPageLink = "Client No." = field("No.");
                }

            }
        }

        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin
                        GetBusinessSctor();
                        if Source = Source::Mobile then
                            Validate(Name);

                        IF "Repeating Client" then
                            TestField("Customer No.");

                        if "Charge fees on Guaranteed Amt" then
                            TestField("Pct. Guarantee Applied");
                        GuaranteeMngt.ValidateFields(Rec, Rec."Application Status"::"Commitment Paid");
                        GuaranteeMngt.GenderCount(Rec);
                        if ApprovalsMgmtExt.CheckGuaranteeAppApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendGuaranteeAppforApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelGuaranteeAppforApproval(Rec);

                    end;
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction();
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RUNMODAL;
                    end;
                }

            }
            group(AttachmentstoEDMS)
            {
                action("Attach Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment to EDMS. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                    begin
                        OnAttachDocuments(Rec);
                    end;
                }
                action("View Attached Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'View attached files in EDMS.';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var

                    begin
                        OnViewAttachedDocuments(Rec);
                    end;
                }
            }
        }
    }
    var
        ProductType: Record Products;
        Portfolio: Boolean;
        Traditional: Boolean;
        GuaranteeSetup: Record "Guarantee Management Setup";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approval Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        GuaranteeMngt: Codeunit "Guarantee Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        businesssector: Record "Subsector & Line of Business";
        FieldsVisibility: Boolean;
        ShareHoldersVisibility: Boolean;

    trigger OnInit()
    begin
        Portfolio := true;
        Traditional := true;
        FieldsVisibility := true;
        ShareHoldersVisibility := true;
    end;

    trigger OnOpenPage()

    begin
        SetControlAppearance();
        Validate("Date of Birth");
        Validate(Product);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        Validate("Date of Birth");
        Validate(Product);
    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;
        Validate("Date of Birth");
        Validate(Product);
    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;


    local procedure GetBusinessSctor()

    begin
        businesssector.Reset();
        businesssector.SetRange("Client No.", "No.");
        if not businesssector.FindFirst() then
            Error('Please fill in Subsector and Line of Business');

    end;

    procedure FnSaveBase64Signature(): Boolean
    var
        //Base64Convert: Codeunit "Base64 Convert";
        //TempBlob: Codeunit "Temp Blob";
        RecordRef: RecordRef;
        OutStream: OutStream;
    begin

    end;

}