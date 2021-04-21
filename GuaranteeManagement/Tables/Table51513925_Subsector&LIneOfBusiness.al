table 51513925 "Subsector & Line of Business"
{
    DataClassification = ToBeClassified;
    Caption = 'Subsector & Line of Business';
    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            AutoIncrement = true;

        }
        field(2; "Client No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Client No.';
        }
        field(3; "Subsector"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subsector';
            TableRelation = Subsector;
        }
        field(4; "Line of Business"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Line of Business';
            TableRelation = "Line Of Business";// where (Subsector = field (Subsector));

            trigger onvalidate()
            var
                LineofBuss: Record "Line Of Business";
            begin
                LineofBuss.Reset();
                LineofBuss.SetRange(Code, "Line of Business");
                if LineofBuss.FindFirst() then
                    Subsector := LineofBuss.Subsector
                else
                    Subsector := '';

            end;
        }

        field(5; "Fund Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Fund Amount';
        }
        field(6; Comments; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(7; "No. of Animals"; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'No. of Animals';
        }
        field(8; "Type of Breed"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Breed';
            OptionMembers = " ",Improved,Local,Traditional,Layers,Broilers,Kroilers,Sasso;
        }
        field(9; "Farming Method"; option)
        {
            DataClassification = CustomerContent;
            caption = 'Farmin Method';
            OptionMembers = " ","Fish pond","Fish Cage",Aquaponics,"Community Forest","Private Farm","Zero Grazing","Open Field Grazing","In Cages","Without Cages";
        }
        field(10; "Farm Size"; Option)
        {
            DataClassification = ToBeClassified;
            caption = 'Farm Size';
            OptionMembers = " ","Less than 1 Acre","Over 1-5 Acres","Over 5-10 Acres","Over 10 Acres";
        }
        field(11; "Technology Type"; Option)
        {
            DataClassification = ToBeClassified;
            caption = 'Technology Type';
            OptionMembers = " ",Drip,"Centre Pivot","Furrow/Canal",Flooding;
        }
        field(13; Type; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Types where (Subsector = field (Subsector));
        }
        field(14; Technology; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Technology where ("Business Type" = field ("Line of Business"), SubSector = field (Subsector));
        }
    }

    keys
    {
        key(PK; "Line No.", "Client No.")
        {
            Clustered = true;
        }
        key(PK2; "Client No.", Subsector, "Line of Business")
        {
            Unique = true;
        }
    }

    var
        myInt: Integer;

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