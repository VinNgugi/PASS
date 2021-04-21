xmlport 51513030 "Employee Transactions"
{
    Format = VariableText;
    Caption = 'Import Employee Transactions';
    Direction = Import;
    schema
    {
        textelement(Employee)
        {
            tableelement(pvlines1; "PV Lines1")
            {
                fieldattribute(HeaderNo; pvlines1.No)
                {

                }
                fieldattribute(AccType; pvlines1."Account Type")
                {

                }
                fieldattribute(AccNo; pvlines1."Account No")
                {

                }
                fieldattribute(Description; pvlines1.Description)
                {

                }
                fieldattribute(Quantity; pvlines1.Quantity)
                {

                }
                fieldattribute(UnitPrice; pvlines1."Unit Price")
                {

                }
                fieldattribute(Dim1; pvlines1."Global Dimension 1 Code")
                {

                }
                fieldattribute(Dim2; pvlines1."Global Dimension 2 Code")
                {

                }
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
        Columnheader := true;
        CountVar := 0;
    end;

    var
        CountVar: Integer;
        Columnheader: Boolean;
}