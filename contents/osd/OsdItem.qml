/* THIS IS A MODIFIED VERSION
 *
 * Copyright 2014 Martin Klapetek <mklapetek@kde.org> (Original)
 * Copyright 2019 Koneko-Nyaa (Changes)
 * Copyright 2020 Robert Fry (Changes)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtra

Item {
    property QtObject rootItem

    property int padding: Math.round(units.iconSizes.medium / 10)
    height: icon.width
    width: label.x + label.width

    // Determine the width of the label when showing the progress bar
    TextMetrics {
        id: labelMetricsP
        font: label.font
        text: "000"
    }

    // // Determine the width of the label when not showing the progress bar
    TextMetrics {
        id: labelMetricsT
        font: label.font
        text: rootItem.osdValue ? rootItem.osdValue : ""
    }

    // The icon asset
    PlasmaCore.IconItem {
        id: icon
        width: units.iconSizes.medium
        height: parent.height
        source: rootItem.icon
    }

    // The progress bar asset
    PlasmaComponents.ProgressBar {
        id: progressBar
        x: icon.x + icon.width + padding
        width: Math.round(Screen.width / 750) * 100
        height: parent.height
        visible: rootItem.showingProgress
        minimumValue: 0
        maximumValue: 100
        value: Number(rootItem.osdValue)
    }

    // The label text asset
    PlasmaExtra.Heading {
        id: label
        x: rootItem.showingProgress ? (progressBar.x + progressBar.width + 6 + padding) : (icon.x + icon.width + padding)
        width: rootItem.showingProgress ? (labelMetricsP.width) : Math.max((progressBar.width + padding + labelMetricsP.width), labelMetricsT.width)
        height: parent.height
        visible: true
        text: rootItem.osdValue ? rootItem.osdValue : ""
        horizontalAlignment: Text.AlignHCenter
        maximumLineCount: 1
        minimumPointSize: theme.defaultFont.pointSize
        fontSizeMode: Text.HorizontalFit
    }
}