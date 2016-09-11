package info.thebleedingedge.randoomer

import org.scaloid.common._
import scala.util.Random

import android.graphics.Color
import android.text.InputType
import android.view.Gravity


class Randoomer extends SActivity {
  onCreate {
    val r = scala.util.Random
    def getNumber(min:Int, max:Int):Int = {
      if(min > max)
        return 0

      min + r.nextInt(1+max-min)
    }
    lazy val number = new STextView(getNumber(1,6).toString)
    lazy val rMin = new SEditText("1") inputType InputType.TYPE_CLASS_NUMBER
    lazy val rMax = new SEditText("6") inputType InputType.TYPE_CLASS_NUMBER

    contentView = new SVerticalLayout {
      style {
        case b: SButton => b.textColor(Color.RED)
        case t: STextView => t textSize 10.dip
      }
      STextView("Generate random numbers within a given range.")
      new SLinearLayout {
        STextView("min: ").wrap
        rMin.here
      }.here
      new SLinearLayout {
        STextView("max: ").wrap
        rMax.here
      }.here
      STextView("min <= X <= max") textSize 20.dip gravity Gravity.CENTER
      SButton("Generate").onClick(number.text = getNumber(rMin.getText.toString.toInt, rMax.getText.toString.toInt).toString)
      new SLinearLayout {
        STextView("X = ").wrap textSize 50.dip
        number.here textSize 50.dip
      }.here


      STextView("Hint: In the case that max < min, 0 will be returned!")
    } padding 20.dip
  }

}
