xmlport 51513021 "Import Group Members"
{
    Format = VariableText;
    Caption = 'Import Group Members';
    Direction = Import;
    schema
    {
        textelement(GroupMembers)
        {
            tableelement(GroupMember; "Group Member")
            {

                fieldattribute(MemberCode; GroupMember."Member Code")
                {

                }
                fieldattribute(Name; GroupMember.Name)
                {

                }
                fieldattribute(DOB; GroupMember."Date of Birth")
                {

                }
                fieldattribute(Gender; GroupMember.Gender)
                {

                }
                fieldattribute(AppliedAmt; GroupMember."Applied Amount")
                {

                }
                fieldattribute(Education; GroupMember.Education)
                {

                }
                fieldattribute(Occupation; GroupMember.Occupation)
                {

                }
                fieldattribute(Position; GroupMember.Position)
                {

                }



                trigger OnBeforeInsertRecord()

                begin
                    GroupMember."No." := GroupAppNo;

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
        Columnheader := true;
        CountVar := 0;
    end;

    procedure GetRecHeader(var AppRec: Record "Group Member")

    begin
        GroupAppNo := AppRec."No.";
    end;

    var
        CountVar: Integer;
        Columnheader: Boolean;

        GroupAppNo: Code[20];
}