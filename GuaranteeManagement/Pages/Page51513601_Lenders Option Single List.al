page 51513601 "Lenders Option Single List"
{
    PageType = List;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Tasks;
    SourceTable = "Lenders Option Single CGC";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Seq. No."; "Seq. No.")
                {

                }
                field("Financial Institution Code"; "Financial Institution Code")
                {

                }
                field("Reference No."; "Reference No.")
                {

                }
                field("Reference Date"; "Reference Date")
                {

                }
                field(Description; Description)
                {

                }
                field("From CGC No."; "From CGC No.")
                {

                }
                field("To CGC No."; "To CGC No.")
                {

                }
                field("No. of Loans"; "No. of Loans")
                {

                }
                field("Total Principal Loan"; "Total Principal Loan")
                {

                }
                field("Credit Guarantee %"; "Credit Guarantee %")
                {

                }
                field("CGC Issued"; "CGC Issued")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Reporting)
        {
            action("Generate Certificate")
            {

                Image = ViewJob;
                Promoted = true;

                trigger OnAction();
                begin
                    RESET;
                    SETFILTER("Reference No.", "Reference No.");
                    REPORT.RUN(51513402, TRUE, TRUE, Rec);
                end;
            }
            action("Generate Option List")
            {

                Image = Report;
                Promoted = true;
                //RunObject = report "Single Lender Option CGC";
                trigger OnAction();
                begin
                    RESET;
                    SETFILTER("Reference No.", "Reference No.");
                    REPORT.RUN(51513401, TRUE, TRUE, Rec);

                end;
            }
            action("Issue CGC")
            {
                Caption = 'Issue CGC';
                ApplicationArea = "#Basic,#Suite";
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Issue Credit Guarantee Certificate';

                trigger OnAction()
                var
                    LOHeader: Record "Lenders Option Journal Header";
                    Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
                begin
                    RESET;
                    SETFILTER("Reference No.", "Reference No.");
                    CalcFields("No. of Loans", "Total Principal Loan");
                    IF not "CGC Issued" THEN BEGIN
                        if CONFIRM('Do you want to issue certificate for %1 Clients? Total principal is %2', FALSE, "No. of Loans",


                                        "Total Principal Loan") then begin


                            contracts.Reset;
                            contracts.SetRange("Reference No.", "Reference No.");
                            contracts.SetRange("Contract Status", contracts."Contract Status"::"Loan Granted");
                            if contracts.FindFirst() then begin
                                repeat
                                    GuaranteeMngt.IssueCGC(contracts);
                                    contracts."Previous Status" := contracts."Contract Status";
                                    contracts."Contract Status" := contracts."Contract Status"::"CGC Issued";
                                    contracts."Booked fee Invoiced " := true;
                                    contracts.Modify;
                                until contracts.Next = 0;
                                Message('CGC successfully issued');

                                LOHeader.Reset();
                                LOHeader.SetRange("Reference No.", "Reference No.");
                                if LOHeader.FindFirst() then begin
                                    LOHeader."CGC Issued" := true;
                                    LOHeader.Modify();
                                end;

                                "CGC Issued" := true;
                                Modify;
                                GuaranteeMngt.LOBatchFees(Rec, Feetype::"Booked Fee", "Total Principal Loan", false, "Financial Institution Code", '');

                            end;
                        end;
                    end else
                        Error('CGC has already been issued');
                end;
            }
        }
    }
    var
        CONF_ISSUE_CGC: TextConst ENU = 'Do you want to issue certificate %1 to %2 for %3 Clients? Total principal is %4';
        GuaranteeMngt: Codeunit "Guarantee Management";
        contracts: Record "Guarantee Contracts";
}