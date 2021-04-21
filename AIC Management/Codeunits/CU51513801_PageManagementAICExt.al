codeunit 51513801 "Page Management AIC Ext"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef)
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin

        CASE RecordRef.Number of
            DATABASE::Incubation:
                exit(Page::Incubation);

        end;
    end;

}