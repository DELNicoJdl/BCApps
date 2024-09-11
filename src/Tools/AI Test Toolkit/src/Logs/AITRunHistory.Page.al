// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.TestTools.AITestToolkit;

page 149036 "AIT Run History"
{
    Caption = 'AI Test Suite Run History';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "AIT Run History";
    SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Test Suite Code"; TestSuiteCode)
                {
                    Caption = 'Test Suite Code';
                    ToolTip = 'Specifies the code of the test suite to view results for.';
                    TableRelation = "AIT Test Suite".Code;

                    trigger OnValidate()
                    begin
                        UpdateRunHistory();
                    end;
                }

                field("View By"; ViewBy)
                {
                    Caption = 'View By';
                    ToolTip = 'Specifies whether to view results by tag or version.';

                    trigger OnValidate()
                    begin
                        UpdateRunHistory();
                    end;
                }

                field("Apply Filter"; ApplyLineFilter)
                {
                    Caption = 'Apply Filter';
                    ToolTip = 'Specifies whether to filter results to a specific line or see results of the suite as a whole.';

                    trigger OnValidate()
                    begin
                        UpdateRunHistory();
                    end;
                }
            }

            group("Line Filter")
            {
                Caption = 'Test Line Filter';
                Visible = ApplyLineFilter;

                field("Line No."; LineNo)
                {
                    Caption = 'Test Line';
                    ToolTip = 'Specifies the line to filter to.';
                    TableRelation = "AIT Test Method Line"."Line No." where("Test Suite Code" = field("Test Suite Code"));

                    trigger OnValidate()
                    begin
                        UpdateRunHistory();
                    end;
                }
            }

            group(History)
            {
                repeater("Run History")
                {
                    field(Version; Rec.Version)
                    {
                        Visible = ViewBy = ViewBy::Version;
                        Caption = 'Version';
                        ToolTip = 'Specifies the version.';
                    }
                    field(Tag; Rec.Tag)
                    {
                        Caption = 'Tag';
                        ToolTip = 'Specifies the tag of the version.';
                    }
                    field("No. of Tests - By Version"; Rec."No. of Tests Executed")
                    {
                        Visible = ViewBy = ViewBy::Version;
                        Caption = 'No. of Tests';
                        ToolTip = 'Specifies the number of tests in the version.';
                    }
                    field("No. of Tests Passed - By Version"; Rec."No. of Tests Passed")
                    {
                        Visible = ViewBy = ViewBy::Version;
                        Caption = 'No. of Tests Passed';
                        ToolTip = 'Specifies the number of tests passed in the version.';
                        Style = Favorable;
                    }
                    field("No. of Tests Failed - By Version"; Rec."No. of Tests Executed" - Rec."No. of Tests Passed")
                    {
                        Visible = ViewBy = ViewBy::Version;
                        Editable = false;
                        Caption = 'No. of Tests Failed';
                        ToolTip = 'Specifies the number of tests that failed in the version.';
                        Style = Unfavorable;

                        trigger OnDrillDown()
                        var
                            AITLogEntryCU: Codeunit "AIT Log Entry";
                        begin
                            AITLogEntryCU.DrillDownFailedAITLogEntries(Rec."Test Suite Code", Rec."Line No. Filter", Rec.Version);
                        end;
                    }
                    field("Duration - By Version"; Rec."Total Duration (ms)")
                    {
                        Visible = ViewBy = ViewBy::Version;
                        Caption = 'Total Duration (ms)';
                        ToolTip = 'Specifies Total Duration of the tests for the base version.';
                    }
                    field("No. of Tests - By Tag"; Rec."No. of Tests Executed - By Tag")
                    {
                        Visible = ViewBy = ViewBy::Tag;
                        Caption = 'No. of Tests';
                        ToolTip = 'Specifies the number of tests for the tag.';
                    }
                    field("No. of Tests Passed - By Tag"; Rec."No. of Tests Passed - By Tag")
                    {
                        Visible = ViewBy = ViewBy::Tag;
                        Caption = 'No. of Tests Passed';
                        ToolTip = 'Specifies the number of tests passed for the tag.';
                        Style = Favorable;
                    }
                    field("No. of Tests Failed - By Tag"; Rec."No. of Tests Executed - By Tag" - Rec."No. of Tests Passed - By Tag")
                    {
                        Visible = ViewBy = ViewBy::Tag;
                        Editable = false;
                        Caption = 'No. of Tests Failed';
                        ToolTip = 'Specifies the number of tests that failed for the tag.';
                        Style = Unfavorable;

                        trigger OnDrillDown()
                        var
                            AITLogEntryCU: Codeunit "AIT Log Entry";
                        begin
                            AITLogEntryCU.DrillDownFailedAITLogEntries(Rec."Test Suite Code", Rec."Line No. Filter", Rec.Tag);
                        end;
                    }
                    field("Duration - By Tag"; Rec."Total Duration (ms) - By Tag")
                    {
                        Visible = ViewBy = ViewBy::Tag;
                        Caption = 'Total Duration (ms)';
                        ToolTip = 'Specifies Total Duration of the tests for the base version.';
                    }
                }
            }
        }
    }

    var
        TestSuiteCode: Code[100];
        ViewBy: Enum "AIT Run History - View By";
        LineNo: Integer;
        ApplyLineFilter: Boolean;

    trigger OnOpenPage()
    begin
        UpdateRunHistory();
    end;

    internal procedure SetTestSuite(Code: Code[100])
    begin
        TestSuiteCode := Code;
    end;

    internal procedure FilterToLine(Line: Integer)
    begin
        ApplyLineFilter := true;
        LineNo := Line;
    end;

    local procedure UpdateRunHistory()
    var
        AITLogEntry: Codeunit "AIT Log Entry";
    begin
        if not ApplyLineFilter then
            LineNo := 0;

        AITLogEntry.UpdateRunHistory(TestSuiteCode, LineNo, ViewBy, Rec);
        CurrPage.Update();
    end;
}