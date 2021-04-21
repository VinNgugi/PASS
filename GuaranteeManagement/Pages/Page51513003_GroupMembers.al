page 51513003 "Group Memmbers"
{
    PageType = List;
    Caption = 'Group Members';
    SourceTable = "Group Member";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Member Code"; "Member Code")
                {

                }
                field(Name; Name)
                {

                }
                field("Date of Birth"; "Date of Birth")
                {

                }
                field(Age; Age)
                {

                }
                field(Gender; Gender)
                {

                }
                field("Applied Amount"; "Applied Amount")
                {

                }
                field("Certificate No."; "Certificate No.")
                {

                }
                field("Certificate Amount"; "Certificate Amount")
                {

                }
                field("Loan No."; "Loan No.")
                {

                }
                field("CGC Date"; "CGC Date")
                {

                }
                field("Certificate Start Date"; "Certificate Start Date")
                {

                }
                field("Certificate Expiry Date"; "Certificate Expiry Date")
                {

                }
                field("CGF %"; "CGF %")
                {

                }
                field("Comm. %"; "Comm. %")
                {

                }
                field(Education; Education)
                {

                }
                field(Occupation; Occupation)
                {

                }
                field(Position; Position)
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
                    importport: XmlPort "Import Group Members";
                begin
                    importport.GetRecHeader(Rec);
                    importport.Run();
                end;
            }
        }

    }

    trigger OnOpenPage()

    begin
        Validate("Date of Birth");
    end;

    trigger OnAfterGetRecord()
    begin
        Validate("Date of Birth");
    end;
}