page 51513589 "BP with Bank Card"
{
    Caption = 'BP with Bank Card';
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Guarantee Contracts";
    SourceTableView = sorting("No.") where("Contract Status" = FILTER("BP with Bank"));
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Applicant';
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

                field(Address; Address)
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                }

                field("E-Mail"; "E-Mail")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = false;
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
                field("Linkage fee Invoiced"; "Linkage fee Invoiced")
                {
                    Editable = false;
                }
                field("Linkage fee Invoice Amount"; "Linkage fee Invoice Amount")
                {
                    Editable = false;
                }
                field("Linkage fee Paid"; "Linkage fee Paid")
                {
                    Editable = false;
                }
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {
                    Caption = 'Bank';
                    ToolTip = 'Specifies receivables (bank) account number.';
                }
                field("Bank Branch"; "Bank Branch")
                {
                    Editable = false;
                }
                field("Submit to Bank Date"; "Submit to Bank Date")
                {
                    Editable = false;
                }
                field("Pct. Guarantee Applied"; "Pct. Guarantee Applied")
                {
                    Editable = false;
                }
                field("Contract Status"; "Contract Status")
                {
                    Editable = false;
                }


            }
            group("Loan Details")
            {
                field(Product; Product)
                {

                }
                field("Type of Facility"; "Type of Facility")
                {

                }
                field("Loan No."; "Loan No.")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {
                    Caption = 'Requested Loan Amount';
                    Editable = false;
                }
                field("Approved Loan Amount"; "Approved Loan Amount")
                {

                }
                field("Approved Loan Currency"; "Approved Loan Currency")
                {
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter("Approved Loan Currency", "Approved Loan Currency Factor", "Application Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("Approved Loan Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Loan Issued Date"; "Loan Issued Date")
                {

                }
                field("Pct. Guarantee Approved"; "Pct. Guarantee Approved")
                {

                }
            }
            group("Guarantee Details")
            {
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("CGC Committed Funds"; "CGC Committed Funds")
                {
                    Editable = false;
                }
                field("PASS Guarantee Amount"; "PASS Guarantee Amount")
                {
                    Editable = false;
                    Caption = 'PASS Deposit Funds Required';
                }
                field("SIDA Guarantee Amount"; "SIDA Guarantee Amount")
                {
                    Editable = false;
                }
                field("IFC Guarantee Amount"; "IFC Guarantee Amount")
                {
                    Editable = false;
                }
            }
            part(Subsctor; "Subsector & Line of Business")
            {
                Caption = 'Subsector & Line of Business';
                SubPageLink = "Client No." = field("No.");
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
        area(Processing)
        {
            action("Return to BP Pipeline")
            {
                Caption = 'Return to BP Pipeline';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GuaranteeMngt: Codeunit "Guarantee Management";
                    CONF_LOAN_GRANTED: TextConst ENU = 'Do you want Return to %1 BP Pipeline?';
                begin
                    IF CONFIRM(CONF_LOAN_GRANTED, FALSE, "No.") THEN BEGIN
                        GuaranteeMngt.ValidateContractFields(Rec, "Previous Status");
                        "Contract Status" := "Previous Status";

                        Message('Successfully returned');
                        CurrPage.Close();

                    end;
                end;

            }
            action("Fee Waiver Aapplication")
            {

                Caption = 'Fee Waiver Aapplication';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Fee Waiver Application";
                RunPageLink = "Client No." = field("No.");
            }

            action("Loan Approved")
            {
                Caption = 'Loan Approved';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GuaranteeMngt: Codeunit "Guarantee Management";
                    CONF_LOAN_GRANTED: TextConst ENU = 'Do you want to register loan of %2 for contract %1?';
                begin
                    IF CONFIRM(CONF_LOAN_GRANTED, FALSE, "No.", "Approved Loan Amount") THEN BEGIN
                        GetLinkageInv;
                        GuaranteeMngt.LoanGranted(Rec);

                        "Contract Status" := "Contract Status"::"Loan Granted";
                        "Previous Status" := "Contract Status";
                        Modify;
                        Message('Successfully registered');
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
                RunPageLink = "Table ID" = CONST(51513000), "No." = FIELD("No.");
            }


        }
    }
    var
        ChangeExchangeRate: Page "Change Exchange Rate";

    trigger OnOpenPage()

    begin
        Validate("Date of Birth");
        GetLinkageInv;
    end;

    procedure GetLinkageInv()
    var
        Appfeeinv: Record "Sales Invoice Header";
        AppfeeInvLines: Record "Sales Invoice Line";
    begin
        if "Linkage fee Invoice Amount" = 0 then begin
            Appfeeinv.Reset;
            Appfeeinv.SetRange("Guarantee Application No.", "No.");
            Appfeeinv.SetRange("Guarantee Entry Type", Appfeeinv."Guarantee Entry Type"::"Linkage Banking");
            if Appfeeinv.FindFirst then begin
                AppfeeInvLines.Reset();
                AppfeeInvLines.SetRange("Document No.", Appfeeinv."No.");
                if AppfeeInvLines.FindFirst then begin
                    "Linkage fee Invoice Amount" := AppfeeInvLines."Amount Including VAT";
                    Modify();
                end;
            end;
        end;
    end;
}






