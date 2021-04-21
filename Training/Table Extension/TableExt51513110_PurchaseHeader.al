tableextension 51513110 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(65001; "From Training Tuition"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'From Training Tuition';
        }
        field(65002; "Training Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Training Code';
            //TableRelation = "Training Request"."Request No." WHERE ("Ready For Imprest" = CONST (true));
        }
    }

    var
        myInt: Integer;
}