page 51513370 "Claim Lines"
{
    // version HR

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Claim Line";
    Caption = 'Claim Lines';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Claim No"; "Claim No")
                {
                    Visible = false;
                }
                field("Employee No"; "Employee No")
                {
                    NotBlank = true;
                    Visible = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    NotBlank = true;
                }
                field("Visit Date"; "Visit Date")
                {
                    NotBlank = true;
                }
                field("Policy Start Date"; "Policy Start Date")
                {
                }
                field("Patient No"; "Patient No")
                {
                    Caption = 'Dependant';
                    NotBlank = true;
                }
                field("Patient Name"; "Patient Name")
                {
                    NotBlank = true;
                }
                field(Relationship; Relationship)
                {
                }
                field("Hospital/Specialist"; "Hospital/Specialist")
                {
                    NotBlank = true;
                }
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                field("Claim Type"; "Claim Type")
                {
                }
                field("Invoice Number"; "Invoice Number")
                {
                    Caption = 'Invoice Number/Receipt No';
                    NotBlank = true;
                }
                field(Amount; Amount)
                {
                    NotBlank = true;
                }
                field(Settled; Settled)
                {
                }
                field("Cheque No"; "Cheque No")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Claim Type" := "Claim Type"::"Out Patient";
    end;
}

