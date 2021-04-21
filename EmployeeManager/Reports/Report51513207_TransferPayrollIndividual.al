report 51513207 "Transfer Payroll Individual"
{
    Caption = 'Transfer Payroll Individual';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer to Journal.rdl';
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field("Payroll Period"; MonthStartDate)
                {
                    TableRelation = "Payroll Period"."Starting Date";

                    /*trigger OnLookup(Text: Text): Boolean;
                    begin
                        PayrollPeriod.RESET;
                        if PAGE.RUNMODAL(51513085, PayrollPeriod) = ACTION::LookupOK then
                            MonthStartDate := PayrollPeriod."Starting Date";
                    end;*/
                }
                field("Employee Posting Group"; PostingGroup)
                {
                    TableRelation = "Staff Posting Group".Code;

                    /*trigger OnLookup(Text: Text): Boolean;
                    begin
                        StaffPostingGroup.RESET;
                        if PAGE.RUNMODAL(51513051, StaffPostingGroup) = ACTION::LookupOK then
                            PostingGroup := StaffPostingGroup.Code;
                    end;*/
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }

    }

    trigger OnInitReport();
    begin

    end;


    trigger OnPreReport();
    begin

    end;

    trigger OnPostReport();
    begin
        CodeFactory.FnTransferPayrollToJournal(MonthStartDate, PostingGroup);
    end;

    var
        MonthStartDate: Date;
        PayrollPeriod: Record "Payroll Period";
        CodeFactory: Codeunit "Code Factory";
        PostingGroup: Code[20];
        StaffPostingGroup: Record "Staff Posting Group";
}