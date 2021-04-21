xmlport 51513600 "Import Claim Lines"
{
    Format = VariableText;
    Caption = 'Import Aging Report';
    Direction = Import;

    schema
    {
        textelement(ClaimLines)
        {
            tableelement(GuaranteeClaimLine; "Guarantee Claim Line")
            {
                fieldattribute(HeaderNo; GuaranteeClaimLine."Claim No.")
                {

                }
                fieldattribute(ContractNo; GuaranteeClaimLine."Contract No.")
                {

                }
                fieldattribute(ClaimAmount; GuaranteeClaimLine."Claim Amount")
                {

                }

                trigger OnBeforeInsertRecord()

                begin


                end;

                trigger OnAfterInsertRecord()
                var
                    myInt: Integer;
                begin
                    GuaranteeClaimLine.Validate("Contract No.");
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
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }
    trigger OnPreXmlport()

    begin

    end;

    trigger OnPostXmlport()
    var
        myInt: Integer;
    begin
        Message('Import Complete. Please Proceed to process the claim');
    end;

    var
}