page 51513011 "Application Pre-Appraisal"
{
    PageType = Card;

    SourceTable = "Guarantee Application";
    Caption = 'Application Pre-Appraisal Card';
    SourceTableView = sorting ("No.") where (Status = filter (Released), "Application Status" = FILTER (" " | "Commitment Paid"));

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
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    Editable = false;
                }
                field(Name; Name)
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }


                field(Product; Product)
                {
                    Editable = false;
                }
                field("Type of Facility"; "Type of Facility")
                {

                }
                field("Business Ownership Type"; "Business Ownership Type")
                {
                    Editable = false;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    Editable = false;

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
                    Editable = false;
                }
                field("BDS/BDO"; "BDS/BDO")
                {

                }
                field("Application fee Invoiced"; "Application fee Invoiced")
                {
                    Editable = false;
                }
                field("Application fee Invoice Amount"; "Application fee Invoice Amount")
                {
                    Editable = false;
                }
                field("Application fee Paid"; "Application fee Paid")
                {
                    Editable = false;
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
            group("Environmental Impact Assessment")
            {
                field("CheckedforE&SSustainability?"; "CheckedforE&SSustainability?")
                {
                    Caption = 'Has the project been assessed for environmental and social sustainability?';
                }
                field("MeetMinimumRequirements?"; "MeetMinimumRequirements?")
                {
                    Caption = 'Does the project meet minimum requirements';
                }
                field("MitigationMeasuresAgreed?"; "MitigationMeasuresAgreed?")
                {
                    caption = 'Plan for improvement agreed with client?';
                }
                field("InvestmentInGreenSolutions?"; "InvestmentInGreenSolutions?")
                {
                    Caption = 'Does the project include investment in Green solutions?';
                }
                field(InvestmentInGreenSum; InvestmentInGreenSum)
                {
                    Caption = 'Investment In Green Solutions Summary';
                    MultiLine = true;
                }
                part(greenActivities; "Green Activities Entries")
                {
                    Caption = 'Does the project include green activities?';
                    SubPageLink = "Contract No." = field ("No.");

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
                action("Pre-Appraise")
                {
                    Caption = 'Pre-Appraise';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GuaranteeMngt: Codeunit "Guarantee Management";
                    begin
                        GetAppInv();
                        if Confirm('Are you sure you want to pre appraise %1 application', false, "No.") then begin
                            GuaranteeMngt.BDO_Appraisal(Rec);
                            "Previous Status" := "Application Status";
                            "Application Status" := "Application Status"::"Pre-Appraised";

                            Message('Application %1 successfully submitted to contract preparation', "No.");
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
            action(PullGreenActivities)
            {
                Caption = 'Populate Green Activities';
                Image = Bin;

                ApplicationArea = All;

                trigger OnAction();

                begin
                    //**********************InsertGreenActivities*****************************//
                    if "No." <> '' then
                        FnInsertGreenActivities("No.");

                end;
            }
        }

    }
    var
        ObjGreenSetup: Record "Green Activities Setup";
        ObjGreenEntries: Record "Green Activities Entries";

    trigger OnOpenPage()

    begin
        GetAppInv;
    end;

    procedure GetAppInv()
    var
        Appfeeinv: Record "Sales Invoice Header";
        AppfeeInvLines: Record "Sales Invoice Line";
    begin
        if "Application fee Invoice Amount" = 0 then begin
            Appfeeinv.Reset;
            Appfeeinv.SetRange("Guarantee Application No.", "No.");
            Appfeeinv.SetRange("Guarantee Entry Type", Appfeeinv."Guarantee Entry Type"::"Application Fee");
            if Appfeeinv.FindFirst then begin
                AppfeeInvLines.Reset();
                AppfeeInvLines.SetRange("Document No.", Appfeeinv."No.");
                if AppfeeInvLines.FindFirst then begin
                    "Application fee Invoice Amount" := AppfeeInvLines."Amount Including VAT";
                    Modify();
                end;
            end;
        end;
    end;
}
