report 51513271 "Employee Contracts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employee Contracts.rdl';
    Caption = 'Employee Contracts';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(Employee_No; Employee."No.")
            {
            }
            column(Employee_Name; Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name")
            {
            }
            column(Start_Date; FromD)
            {
            }
            column(End_Date; ToD)
            {
            }

            trigger OnAfterGetRecord();
            begin
                FromD := 0D;
                ToD := 0D;
                Contracts.RESET;
                Contracts.SETRANGE("Employee No", Employee."No.");
                if Contracts.FINDLAST then begin
                    FromD := Contracts."Contract Start Date";
                    ToD := Contracts."Contract End Date";
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        FromD: Date;
        ToD: Date;
        Contracts: Record "Employee Contracts";
}

