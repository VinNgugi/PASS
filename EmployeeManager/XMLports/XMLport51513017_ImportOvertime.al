xmlport 51513017 "Import Overtime1"
{
    Format = VariableText;

    schema
    {
        textelement(OvertimeH)
        {
            tableelement("Overtime Line"; "Overtime Line")
            {
                XmlName = 'OvertimeLine';
                fieldelement(EmployeeNo; "Overtime Line"."Employee No")
                {
                }
                fieldelement(Date; "Overtime Line".Date)
                {
                }
                fieldelement(Hours; "Overtime Line".Hours)
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    "Overtime Line".VALIDATE(Date);
                end;

                trigger OnBeforeInsertRecord();
                begin
                    "Overtime Line".Code := DocNo;
                    "Overtime Line"."pay period" := PayPeriod;
                end;
            }
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

    var
        DocNo: Code[10];
        PayPeriod: Date;
        OLines: Record "Overtime Line";

    procedure GetRec(TRec: Record "Overtime Header");
    begin
        DocNo := TRec.Code;
        PayPeriod := TRec."Pay Period";
    end;
}

