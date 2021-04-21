page 51513013 "Contract Preparation Card"
{
    PageType = Card;

    SourceTable = "Guarantee Application";
    Caption = 'Contract Preparation Card';
    SourceTableView = sorting ("No.") where ("Application Status" = FILTER ("Pre-Appraised"));
    DeleteAllowed = false;
    InsertAllowed = false;
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
                field("BP Amount"; "BP Amount")
                {

                }
                field("BP Amount LCY"; "BP Amount LCY")
                {
                    Editable = false;
                }
                field("BP Currency"; "BP Currency")
                {
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter("BP Currency", "BP Currency Factor", "Application Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("BP Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;
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
                action("Contract Prepared")
                {
                    Caption = 'Contract Prepared';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GuaranteeMngt: Codeunit "Guarantee Management";
                    begin
                        TestField("Contract Description");
                        if Confirm('Is contract for %1 application ready for signing?', false, "No.") then begin
                            GuaranteeMngt.Contract_Prepared(Rec);
                            "Previous Status" := "Application Status";
                            "Application Status" := "Application Status"::"Contract Prepared";
                            Message('Application %1 successfully sumbitted to contract signing stage', "No.");
                            CurrPage.Close();
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
    var
        ChangeExchangeRate: Page "Change Exchange Rate";
}
