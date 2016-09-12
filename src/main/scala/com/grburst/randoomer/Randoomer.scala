package com.grburst.randoomer

import org.scaloid.common._
import spire.implicits._
import spire.math._
import spire.random._

import android.graphics.Color
import android.text.InputType
import android.view.Gravity


class Randoomer extends SActivity {
  onCreate {
    val r = rng.Cmwc5()
    def getNumber(min:BigInt, max:BigInt):Option[BigInt] = {
      if(min > max)
        return None

      val dist = Dist.uniform[BigInt](min, max)
      Some(r.next[BigInt](dist))
    }
    def generate() = {
      val bMin = BigInt(rMin.getText.toString)
      val bMax = BigInt(rMax.getText.toString)
      getNumber(bMin, bMax) match {
        case Some(res) => number.text = res.toString
        case None => number.text = "min > max"
      }
    }
    lazy val number = new STextView()
    lazy val rMin = new SEditText("1") inputType InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_SIGNED
    lazy val rMax = new SEditText("6") inputType InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_SIGNED
    generate()

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
      SButton("Generate").onClick(generate)
      new SLinearLayout {
        STextView("X = ").wrap textSize 50.dip
        number.here textSize 50.dip
      }.here


    } padding 20.dip
  }

}
