table 51513307 "Medical Scheme Lines"
{
    // version HR

    //DrillDownPageID = 
    //LookupPageID = "Employee Transfer Card";
    Caption = 'Medical Scheme Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Medical Scheme No"; Code[10])
        {
            Caption = 'Medical Scheme No';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Schemeheader1.GET("Medical Scheme No") then begin
                    "Fiscal Year" := Schemeheader1."Fiscal Year";
                    // MESSAGE('%1',"Fiscal Year");
                end;
            end;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Employee."No." WHERE (Status = FILTER (Active));
        }
        field(3; Relationship; Code[20])
        {
            Caption = 'Relationship';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "HR Relative".Code;
        }
        field(4; SurName; Text[50])
        {
            Caption = 'SurName';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(5; "Other Names"; Text[100])
        {
            Caption = 'Other Names';
            DataClassification = CustomerContent;
            NotBlank = true;
            //This property is currently not supported
            //TestTableRelation = false;
            // ValidateTableRelation = false;
        }
        field(6; "ID No/Passport No"; Text[50])
        {
            Caption = 'ID No/Passport No';
            DataClassification = CustomerContent;
        }
        field(7; "Date Of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Birth';
        }
        field(8; Occupation; Text[100])
        {
            Caption = 'Occupation';
            DataClassification = CustomerContent;
        }
        field(9; Address; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(10; "Office Tel No"; Text[100])
        {
            Caption = 'Office Tel No';
            DataClassification = CustomerContent;
        }
        field(11; "Home Tel No"; Text[50])
        {
            Caption = 'Home Tel No';
            DataClassification = CustomerContent;
        }
        field(12; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(13; "Service Provider"; Code[20])
        {
            Caption = 'Service Provider';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(14; "Fiscal Year"; Code[10])
        {
            Caption = 'Fiscal Year';
            DataClassification = CustomerContent;
        }
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(16; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionMembers = " Male",Female;
        }
        field(17; "In-Patient Entitlement"; Decimal)
        {
            Caption = 'In-Patient Entitlement';
            DataClassification = CustomerContent;
        }
        field(18; "Out-Patient Entitlment"; Decimal)
        {
            Caption = 'Out-Patient Entitlment';
            DataClassification = CustomerContent;
        }
        field(19; "Amount Spend (In-Patient)"; Decimal)
        {
            Caption = 'Amount Spend (In-Patient)';
            DataClassification = CustomerContent;
        }
        field(20; "Amout Spend (Out-Patient)"; Decimal)
        {
            Caption = 'Amout Spend (Out-Patient)';
            DataClassification = CustomerContent;
        }
        field(21; "Policy Start Date"; Date)
        {
            Caption = 'Policy Start Date';
            DataClassification = CustomerContent;
        }
        field(22; "Medical Cover Type"; Option)
        {
            Caption = 'Medical Cover Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","In House",Outsourced;
        }
    }

    keys
    {
        key(Key1; "Medical Scheme No", "Line No.", "Other Names", "Employee Code")
        {
        }
    }


    var
        Schemeheader1: Record "Medical Scheme Header";
}

