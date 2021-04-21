page 51513015 "Contract Signing Card"
{
    PageType = Card;

    SourceTable = "Guarantee Application";
    Caption = 'Contract Signing Card';
    SourceTableView = sorting ("No.") where ("Application Status" = FILTER ("Contract Prepared"));
    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Applicant';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field(Name; Name)
                {

                }
                field(Gender; Gender)
                {

                }


                field(Product; Product)
                {

                }
                field("Type of Facility"; "Type of Facility")
                {

                }
                field("Business Ownership Type"; "Business Ownership Type")
                {

                }
                field("Date of Birth"; "Date of Birth")
                {

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
                    Editable = false;
                }
                field("Any Existing Loans"; "Any Existing Loans")
                {

                }
                field("BDS/BDO"; "BDS/BDO")
                {

                }
                field("Contract Description"; "Contract Description")
                {
                    ShowMandatory = true;
                    MultiLine = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 3 Code"; "Global Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Loan Amount"; "Loan Amount")
                {

                }
                field("Loan Amount(LCY)"; "Loan Amount(LCY)")
                {
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {

                }
                field("Have Business Plan?"; "Have Business Plan?")
                {
                    Editable = false;
                }
                field("BP Amount"; "BP Amount")
                {
                    ShowMandatory = true;
                }
                field("BP Amount LCY"; "BP Amount LCY")
                {
                    Editable = false;
                }
                field("BP Currency"; "BP Currency")
                {

                }
                group("Contract Details")
                {
                    field("Contract Signed Date"; "Contract Signed Date")
                    {
                        ShowMandatory = true;
                    }
                }
            }
            group(Project)
            {
                Caption = 'Project Details';
                field("Project Description"; "Project Description")
                {
                    MultiLine = true;
                }
                field("No. of Females"; "No. of Females")
                {
                    Editable = false;
                }
                field("No. of Males"; "No. of Males")
                {
                    Editable = false;
                }
            }
            group(Addresses)
            {
                Caption = 'Address & Contact';
                field(Address; Address)
                {


                }
                field("Address 2"; "Address 2")
                {


                }
                field(City; City)
                {


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
                SubPageLink = "Client No." = field ("No.");
            }
            part("FinancialInformation"; "Guarantee App Financial Info")
            {
                Caption = 'Financial Information';
                SubPageLink = "Application No." = field ("No.");
            }
            part(Attachment; "Required Documents")
            {
                Caption = 'Attachments';
                SubPageLink = "No." = field ("No.");
            }


        }
        area(FactBoxes)
        {
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

                action("Fee Waiver Aapplication")
                {

                    Caption = 'Fee Waiver Aapplication';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "Fee Waiver Application";
                    RunPageLink = "Client No." = field ("No.");
                }
                action("Contract Signing")
                {
                    Caption = 'Contract Signed';
                    Image = ContractPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GuaranteeMngt: Codeunit "Guarantee Management";
                    begin
                        IF Confirm('Does the Client have a Business Plan?', FALSE) then
                            "Have Business Plan?" := true
                        else
                            "Have Business Plan?" := false;
                        IF CONFIRM('Do you want to create contract for %1', FALSE, Name) THEN BEGIN
                            GuaranteeMngt.BDO_SignContracts(Rec);
                            GuaranteeMngt.CreateContract(Rec);
                            Message('Contract for %1 successfully created', Name);
                            CurrPage.Close();
                        end;

                    end;
                }
                action("Undo Contract")
                {
                    Caption = 'Undo Contract';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GuaranteeMngt: Codeunit "Guarantee Management";
                    begin
                        IF CONFIRM('Do you want to undo contract for %1', FALSE, Name) THEN BEGIN
                            GuaranteeMngt.ValidateFields(Rec, "Previous Status");
                            "Application Status" := "Previous Status";

                        end;

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'Shift+Ctrl+D';
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST (51513000), "No." = FIELD ("No.");
                }
            }
        }
    }
}
