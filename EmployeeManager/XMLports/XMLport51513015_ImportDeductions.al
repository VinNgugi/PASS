xmlport 51513015 "Import Deductions"
{
    Format = VariableText;

    schema
    {
        textelement(Deduct)
        {
            tableelement("Deduction Lines"; "Deduction Lines")
            {
                XmlName = 'DeductionLine';
                fieldelement(DedCode; "Deduction Lines".Deduction)
                {
                }
                fieldelement(EmpNo; "Deduction Lines"."Employee No")
                {
                }
                fieldelement(DAmount; "Deduction Lines".Amount)
                {
                }

                trigger OnBeforeInsertRecord();
                begin
                    "Deduction Lines".Code := DocNo;
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

    procedure GetRec(TRec: Record "Import Deductions");
    begin
        DocNo := TRec.Code;
    end;
}

