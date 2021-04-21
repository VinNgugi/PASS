page 51513603 "CGC Aging Journal"
{
    PageType = Worksheet;
    UsageCategory = Tasks;
    SourceTable = "Loan Account Journal Line";
    Caption = 'CGC Aging Journal';
    layout
    {
        area(Content)
        {
            grid(General)
            {
                field(BatchBankCode; BatchBankCode)
                {
                    Caption = 'Financial Institution Code';
                    LookupPageId = "Customer Lookup";
                    Lookup = true;


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerLookup: Page "Customer Lookup";
                        Bank: Record Customer;
                    begin
                        CustomerLookup.LOOKUPMODE(TRUE);
                        IF CustomerLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            CustomerLookup.GETRECORD(Bank);
                            BatchBankCode := Bank."No.";
                        END;
                    end;
                }
            }
            repeater(GroupName)
            {
                field("Reporting Date"; "Reporting Date")
                {
                    Caption = 'Reporting Period End Date';
                }
                field("Contract No."; "Contract No.")
                {

                }
                field("Loan No"; "Loan No")
                {

                }
                field("Customer Name"; "Customer Name")
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field("Approved Amount"; "Approved Amount")
                {

                }
                field("Disbursed Amount"; "Disbursed Amount")
                {

                }
                field("Repayment Installment Amt"; "Repayment Installment Amt")
                {

                }
                field("Total Exposure"; "Total Exposure")
                {

                }
                field("Total Principal Amt Paid "; "Total Principal Amt Paid ")
                {

                }
                field("Outstanding Principal Amt"; "Outstanding Principal Amt")
                {

                }

                field("Interest Amt Accrued"; "Interest Amt Accrued")
                {

                }
                field("Principal Amt In Arrears"; "Principal Amt In Arrears")
                {

                }
                field("Interest Amt In Arrears"; "Interest Amt In Arrears")
                {

                }
                field("Total No. of Installments"; "Total No. of Installments")
                {

                }
                field("No. of Installments In Arrears"; "No. of Installments In Arrears")
                {

                }
                field("Days Past Due"; "Days Past Due")
                {

                }
                field(Guarantee; Guarantee)
                {
                    Caption = 'Guarantee %';
                }

                field("Guarantee Amt"; "Guarantee Amt")
                {

                }
                field("System Classification"; "System Classification")
                {

                }
                field("Loan Value Date"; "Loan Value Date")
                {

                }
                field("Loan Maturity Date"; "Loan Maturity Date")

                {

                }
                field(Validated; Validated)
                {

                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Import from Excel")
            {
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();

                var
                    importport: XmlPort "Aging Report";
                begin
                    importport.Run();
                end;
            }
            action(Validate)
            {
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JournaEntries: Record "Loan Account Entries";
                begin
                    GuaranteeMng.ValidateCGCAging(Rec);
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JournaEntries: Record "Loan Account Entries";
                begin
                    GuaranteeMng.PostCGCAging(Rec);
                end;
            }
        }
    }
    var
        GuaranteeMng: Codeunit "Guarantee Management";
        BatchBankCode: Code[10];
}