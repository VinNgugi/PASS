page 51513587 "Guarante Contract Card"
{
    PageType = Card;
    //Editable = false;
    DeleteAllowed = false;
    SourceTable = "Guarantee Contracts";
    Caption = 'Contract Card';

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

                field(Address; Address)
                {

                }
                field(City; City)
                {

                }
                field("Date of Birth"; "Date of Birth")
                {

                }
                field(Age; Age)
                {

                }
                field(Gender; Gender)
                {

                }
                field("Phone No."; "Phone No.")
                {

                }
                field(Product; Product)
                {

                }
                field("Type of Facility"; "Type of Facility")
                {

                }

                field("Loan Amount"; "Loan Amount")
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field("Contract Description"; "Contract Description")
                {

                }

                field("Contract Status"; "Contract Status")
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
                field("Total Principal Aamount Paid"; "Total Principal Aamount Paid")
                {

                }
                field("Reporting Date"; "Last Aging Date")
                {

                }
                field("Loan Fully Paid"; "Loan Fully Paid")
                {

                }
            }
            group("Application And Loan Information")
            {

                field("Application fee Paid"; "Application fee Paid")
                {
                    ApplicationArea = All;
                }
                field("Application fee Invoiced"; "Application fee Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Application fee Invoice Amount"; "Application fee Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field(Bank; Bank)
                {
                    ApplicationArea = All;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = All;
                }
                field("Submit to Bank Date"; "Submit to Bank Date")
                {
                    ApplicationArea = All;
                }
                field("Loan Amount(LCY)"; "Loan Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Approved Loan Amount"; "Approved Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Loan Amount(LCY)"; "Approved Loan Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Approved Loan Currency"; "Approved Loan Currency")
                {
                    ApplicationArea = All;
                }
                field("Pct. Guarantee Applied"; "Pct. Guarantee Applied")
                {
                    ApplicationArea = All;
                }
                field("Consultancy Fee Paid"; "Consultancy Fee Paid")
                {
                    ApplicationArea = All;
                }
                field("Consultancy Fee Invoiced"; "Consultancy Fee Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Consultancy Fee Invoice Amount"; "Consultancy Fee Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Issued Date"; "Loan Issued Date")
                {
                    ApplicationArea = All;
                }
            }
            group("CGC Information")
            {
                //Editable = false;
                field("CGC No."; "CGC No.")
                {

                }
                field("CGC Amount"; "CGC Amount")
                {

                }
                field("Loan No."; "Loan No.")
                {

                }
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {

                }
                field("Receivables Acc. Name"; "Receivables Acc. Name")
                {
                    Caption = 'Bank';
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {

                }
                field("CGC Date"; "CGC Date")
                {
                    Editable = DatesEditable;
                }
                field("CGC Start Date"; "CGC Start Date")
                {
                    Editable = DatesEditable;
                }
                field("CGC Expiry Date"; "CGC Expiry Date")
                {
                    Editable = DatesEditable;
                }
                field("Loan Maturity Date"; "Loan Maturity Date")
                {
                    Editable = DatesEditable;
                }
                field("Pct. Guarantee Approved"; "Pct. Guarantee Approved")
                {

                }
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("PASS Guarantee Amount"; "PASS Guarantee Amount")
                {

                }
                field("SIDA Guarantee Amount"; "SIDA Guarantee Amount")
                {

                }
                field("IFC Guarantee Amount"; "IFC Guarantee Amount")
                {

                }
                field("Risk Sharing Fee %"; "Risk Sharing Fee %")
                {

                }
                field("Signatory 1 (CGC)"; "Signatory 1 (CGC)")
                {

                }
                field("Signatory 2 (CGC)"; "Signatory 2 (CGC)")
                {

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
                        //Enabled = Portfolio;
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
            group("Environmental Impact Assessment")
            {

                field("CheckedforE&SSustainability?"; "CheckedforE&SSustainability?")
                {
                    Caption = 'Has the project been checked for E&S Sustainability?';
                }
                field("MeetMinimumRequirements?"; "MeetMinimumRequirements?")
                {
                    Caption = 'Does the project meet minimum requirements';
                }
                field("MitigationMeasuresAgreed?"; "MitigationMeasuresAgreed?")
                {
                    caption = 'Mitigation measures agreed? with client? (If answer is not Yes in question 2)';
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
            }
            part(Subsctor; "Subsector & Line of Business")
            {
                Caption = 'Subsector & Line of Business';
                SubPageLink = "Client No." = field("No.");
            }
            part("Aging Information"; "Loan Account Entries")
            {
                SubPageView = sorting("Contract No.", "Reporting Date");
                SubPageLink = "Contract No." = field("No.");
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

            action("Group Memmbers")
            {
                Caption = 'Group Memmbers';
                Image = Group;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page "Group Memmbers";
                RunPageLink = "No." = field("No.");
            }
            action("Print CGC")
            {

                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Report;
                // ToolTip = 'Cancel the approval request.';
                //
                trigger OnAction()

                begin
                    if "Contract Status" = "Contract Status"::"CGC Issued" then begin
                        if "Product Type" = "Product Type"::"Lenders Option" then
                            Validate("Receivables Acc. No.");
                        GuaranteeMngt.PrintCGC(Rec, false);
                    end else
                        Error('You can only Print Certificates for Applications with status %1', "Contract Status"::"CGC Issued");


                end;
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


    trigger OnOpenPage()

    begin
        Validate("Date of Birth");

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        DatesEditable := true;
        if "Contract Status" = "Contract Status"::"CGC Issued" then
            DatesEditable := false;
    end;



    var
        GuaranteeMngt: Codeunit "Guarantee Management";
        DatesEditable: Boolean;

}