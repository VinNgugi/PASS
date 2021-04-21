page 51513119 "Import Overtime"
{
    // version PAYROLL

    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Overtime Excel";
    caption = 'Import Overtime';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Hours Normal"; "Hours Normal")
                {
                }
                field("Hours Double"; "Hours Double")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Add Employees")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    Empl: Record Employee;
                    OvertimeExcel: Record "Overtime Excel";
                begin
                    Empl.RESET;
                    if Empl.FINDFIRST then begin
                        repeat
                            OvertimeExcel.RESET;
                            OvertimeExcel.INIT;
                            OvertimeExcel."Employee No" := Empl."No.";
                            OvertimeExcel."Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                            if not OvertimeExcel.GET(Empl."No.") then
                                OvertimeExcel.INSERT;
                        until Empl.NEXT = 0;
                    end;
                end;
            }
            action("Export To Excel")
            {
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    ConfigPackageTable.SETRANGE("Table ID", DATABASE::"Overtime Excel");
                    if ConfigPackageTable.FINDFIRST then begin
                        if CONFIRM(Text004, true, ConfigPackageTable."Package Code") then
                            ConfigExcelExchange.ExportExcelFromTables(ConfigPackageTable);
                    end;
                end;
            }
            action("Import from Excel")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Begin the migration of legacy data.';

                trigger OnAction();
                var
                    ConfigExcelExchange: Codeunit "Config. Excel Exchange";
                begin
                    ConfigExcelExchange.ImportExcelFromPackage;
                    ApplyPackage();
                end;
            }
            action(Pump)
            {

                trigger OnAction();
                begin
                    OvertimeTemplate.Rundataforpayperiod();
                end;
            }
        }
    }

    var
        ConfigPackageTable: Record "Config. Package Table";
        ConfigExcelExchange: Codeunit "Config. Excel Exchange";
        Text002: Label 'Validate package %1?';
        Text003: Label 'Apply data from package %1?';
        Text004: Label 'Export package %1?';
        OvertimeTemplate: Record "Overtime Template";

    local procedure ApplyPackage();
    var
        ConfigPackageTable: Record "Config. Package Table";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        ConfigPackage: Record "Config. Package";
    begin
        ConfigPackageTable.SETRANGE("Table ID", DATABASE::"Overtime Excel");
        if ConfigPackageTable.FINDFIRST then begin
            if CONFIRM(Text003, true, ConfigPackageTable."Package Code") then begin
                ConfigPackageTable.SETRANGE("Table ID", DATABASE::"Overtime Excel");
                ConfigPackage.GET(ConfigPackageTable."Package Code");
                ConfigPackageMgt.ApplyPackage(ConfigPackage, ConfigPackageTable, true);
            end;
        end;
    end;
}

