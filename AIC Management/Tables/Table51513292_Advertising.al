table 51513823 Advertising_
{
    Caption = 'Advertising';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Need Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
            TableRelation = Incubation."No.";

            trigger OnValidate()

            begin
                /*  RecruitmentNeeds.RESET;
                  RecruitmentNeeds.SETRANGE(RecruitmentNeeds."No.", "Need Code");
                  IF RecruitmentNeeds.FIND('-') THEN begin
                      "Expected Reporting Date" := RecruitmentNeeds."Expected Reporting Date";
                      "Closing Date" := RecruitmentNeeds."End Date";
                      "Opening Date" := RecruitmentNeeds."Start Date";
                  end;*/
            end;
        }
        field(2; "Advertising Media"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Advertising Media';
            TableRelation = Vendor."No.";
            NotBlank = true;
        }
        field(3; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
            NotBlank = true;
        }
        field(4; Aamount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            NotBlank = true;
        }
        field(5; "Advertisement Doc Link"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Advertisement Doc Link';
        }
        field(6; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
        }
        field(7; "Expected Reporting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Reporting Date';
        }
        field(8; "Closing Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Closing Date';
        }
        field(9; "Opening Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Opening Date';
        }
        field(10; "Advertising Method"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Website,Newspapers,Radio,Television,"Social Media";
        }

    }

    keys
    {
        key(PK; "Need Code", "Advertising Media", Date)
        {

        }
    }

    var
        RecruitmentNeeds: Record Incubation;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}