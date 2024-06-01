// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.TestTools.AITestToolkit;

/// <summary>
/// This enum has the Status of the BCCT Line.
/// </summary>
enum 149031 "BCCT Line Status"
{
    Extensible = false;

    /// <summary>
    /// Specifies the initial state.
    /// </summary>
    value(0; " ")
    {
    }

    /// <summary>
    /// Specifies that the BCCT Line state is Starting.
    /// </summary>
    value(10; Starting)
    {
    }
    /// <summary>
    /// Specifies that the BCCT Line state is Running.
    /// </summary>
    value(20; Running)
    {
    }

    /// <summary>
    /// Specifies that the BCCT Line state is Completed.
    /// </summary>
    value(30; Completed)
    {
    }

    /// <summary>
    /// Specifies that the BCCT Line state is Cancelled.
    /// </summary>
    value(40; Cancelled)
    {
    }
}