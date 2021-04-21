tableextension 51513262 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "Employee No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            TableRelation = Employee;
        }

        field(50001; "Imprest Account"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Imprest Account';
            TableRelation = Customer."No." where ("Customer Posting Group" = filter ('STAFF|TEMP/INT'));
        }
        field(50002; HOD; Code[20])
        {
            Caption = 'HOD';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }

        field(5006; Picture; Blob)
        {
            Caption = 'Picture';
            Compressed = false;
            Subtype = Bitmap;
        }
        field(50003; "Immediate Supervisor"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Immediate Supervisor';
            TableRelation = "User Setup"."User ID";
        }


    }
}