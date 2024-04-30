// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Tooling;

using System.Environment;

page 149042 "BCCT CommandLine Card"
{
    Caption = 'BCCT CommandLine Runner';
    PageType = Card;
    Extensible = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Select Code"; BCCTCode)
                {
                    Caption = 'Select Code', Locked = true;
                    ToolTip = 'Specifies the ID of the suite.';
                    ApplicationArea = All;
                    TableRelation = "BCCT Header".Code;

                    trigger OnValidate()
                    var
                        BCCTHeader: record "BCCT Header";
                        BCCTLine: record "BCCT Line";
                    begin
                        if not BCCTHeader.Get(BCCTCode) then
                            Error(CannotFindBCCTSuiteErr, BCCTCode);

                        //BCCTHeader.CalcFields("Total No. of Sessions");
                        CurrentBCCTHeader := BCCTHeader;
                        BCCTLine.SetRange("BCCT Code", BCCTCode);
                        NoOfTests := BCCTLine.Count();
                    end;
                }


                field("No. of Tests"; NoOfTests)
                {
                    Caption = 'No. of Tests', Locked = true;
                    ToolTip = 'Specifies the number of BCCT Suite Lines present in the BCCT Suite';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartNext)
            {
                Enabled = EnableActions;
                ApplicationArea = All;
                Caption = 'Start Next', Locked = true;
                Image = Start;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Starts the next available test.';

                trigger OnAction()
                begin
                    StartNextBCCT();
                end;
            }
        }
    }

    var
        CurrentBCCTHeader: Record "BCCT Header";
        CannotFindBCCTSuiteErr: Label 'The specified BCCT Suite with code %1 cannot be found.', Comment = '%1 = BCCT Suite id.';
        EnableActions: Boolean;
        BCCTCode: Code[10];
        NoOfTests: Integer;

    trigger OnOpenPage()
    var
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        EnableActions := (EnvironmentInformation.IsSaas() and EnvironmentInformation.IsSandbox()) or EnvironmentInformation.IsOnPrem();
    end;

    local procedure StartNextBCCT()
    var
        BCCTStartTests: Codeunit "BCCT Start Tests";
    begin
        BCCTStartTests.StartNextTestSuite(CurrentBCCTHeader);
        CurrentBCCTHeader.Find();
    end;
}