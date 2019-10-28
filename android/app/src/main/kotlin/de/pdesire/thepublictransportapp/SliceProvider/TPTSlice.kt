package de.pdesire.thepublictransportapp.SliceProvider

import android.app.PendingIntent
import android.content.Intent
import android.net.Uri
import androidx.core.graphics.drawable.IconCompat
import androidx.slice.Slice
import androidx.slice.SliceProvider
import androidx.slice.builders.*
import de.pdesire.thepublictransportapp.MainActivity

class TPTSlice : SliceProvider() {

    override fun onBindSlice(sliceUri: Uri): Slice? {
        val activityAction = createActivityAction()
        return if (sliceUri.path == "/launch") {
            list(context!!, sliceUri, ListBuilder.INFINITY) {
                header {
                    title = "The Public Transport öffnen"
                    subtitle = "Einfach besser den Verkehr nutzen"
                    primaryAction = activityAction
                }
            }
        } else {
            list(context!!, sliceUri, ListBuilder.INFINITY) {
                row {
                    title = "The Public Transport öffnen"
                    subtitle = "Die ÖPNV App für dich"
                    primaryAction = activityAction
                }
            }
        }
    }

    override fun onCreateSliceProvider(): Boolean {
        return true
    }

    fun createActivityAction(): SliceAction {
        val intent = Intent(context, MainActivity::class.java)
        return SliceAction.create(
                PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), 0),
                IconCompat.createWithResource(context, de.pdesire.thepublictransportapp.R.drawable.directions_bus),
                ListBuilder.ICON_IMAGE,
                "Enter app"
        )
    }
}