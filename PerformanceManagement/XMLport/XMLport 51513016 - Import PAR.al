xmlport 51513016 "Import PAR"
{
    Format = VariableText;

    schema
    {
        textelement(ImportPAR)
        {
            tableelement("PAR Results"; "PAR Results")
            {
                XmlName = 'ParLines';
                fieldelement(EmployID; "PAR Results"."Employee No")
                {
                }
                fieldelement(Rank; "PAR Results".Rating)
                {
                }

                trigger OnBeforeInsertRecord();
                begin
                    "PAR Results"."Appraisal Period" := DocNo;
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
        DocNo: Code[20];

    procedure GetRec(TRec: Record "Appraisal Periods");
    begin
        DocNo := TRec.Period;
    end;
}

