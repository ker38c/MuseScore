/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore BVBA and others
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtQuick.Layouts 1.15

import MuseScore.NotationScene 1.0
import Muse.UiComponents 1.0
import Muse.Ui 1.0

RowLayout {
    required property StyleItem styleItem
    required property string label
    property string suffix: ''
    property bool inPercentage: false

    StyledTextLabel {
        Layout.fillWidth: true
        id: optionLabel
        horizontalAlignment: Text.AlignLeft
        text: label
    }

    IncrementalPropertyControl {
        Layout.preferredWidth: 80
        Layout.fillWidth: false

        currentValue: inPercentage ? Math.round(styleItem.value * 100) : styleItem.value
        minValue: 0
        maxValue: inPercentage ? 999 : 99
        step: inPercentage ? 1 : 0.01
        decimals: inPercentage ? 0 : 2

        measureUnitsSymbol: inPercentage ? '%' : suffix

        onValueEdited: function(newValue) {
            styleItem.value = inPercentage ? newValue / 100 : newValue
        }
    }

    FlatButton {
        icon: IconCode.UNDO
        enabled: !styleItem.isDefault
        onClicked: styleItem.value = styleItem.defaultValue
    }
}
