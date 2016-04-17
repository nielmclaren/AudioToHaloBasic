
import netP5.*;
import oscP5.*;

public class Halo {

  private OscP5 osc;
  private NetAddress address;

  Halo(OscP5 oscArg, NetAddress addressArg) {
    osc = oscArg;
    address = addressArg;
  }

  /*
   *  Send message to control a halo.
   *
   *  @param
   *  aX : x postion of the halo on the grid, from 0 to 11.
   *  aY : y postion of the halo on the grid, from 0 to 5.
   *  aColor : Color target, rgb format, values from 0. to 1.
   *  aDuration : Duration of the fading to this color in second.
   */
  public void controlHalo(int aX, int aY, color aColor, float aDuration)
  {
      int red   = (aColor >> 16) & 0xFF;
      int green = (aColor >> 8)  & 0xFF;
      int blue  =  aColor        & 0xFF;

      OscMessage message = new OscMessage("/halo");
      message.add(aX);
      message.add(aY);
      message.add((float)red / 255.);
      message.add((float)green / 255.);
      message.add((float)blue / 255.);
      message.add(aDuration);
      osc.send(message, address);
  }


  /*
   *  Send message to control a LED.
   *
   *  @param
   *  aX : x postion of the halo on the grid, from 0 to 11.
   *  aY : y postion of the halo on the grid, from 0 to 5.
   *  aIndexLED : index of the LED on the halo, from 0 to 30.
   *  aColor : Color target, rgb format, values from 0. to 1.
   *  aDuration : Duration of the fading to this color in second.
   */
  public void controlLED(int aX, int aY, int aIndexLED, color aColor, float aDuration)
  {
      int red   = (aColor >> 16) & 0xFF;
      int green = (aColor >> 8)  & 0xFF;
      int blue  =  aColor        & 0xFF;

      OscMessage message = new OscMessage("/led");
      message.add(aX);
      message.add(aY);
      message.add(aIndexLED);
      message.add((float)red / 255.);
      message.add((float)green / 255.);
      message.add((float)blue / 255.);
      message.add(aDuration);
      osc.send(message, address);
  }

  /*
   *  Send message to control a row.
   *
   *  @param
   *  aRow : index of the row, 0 is top, from 0 to 5.
   *  aColor : Color target, rgb format, values from 0. to 1.
   *  aDuration : Duration of the fading to this color in second.
   */
  public void controlRow(int aRow, color aColor, float aDuration)
  {
      int red   = (aColor >> 16) & 0xFF;
      int green = (aColor >> 8)  & 0xFF;
      int blue  =  aColor        & 0xFF;

      OscMessage message = new OscMessage("/row");
      message.add(aRow);
      message.add((float)red / 255.);
      message.add((float)green / 255.);
      message.add((float)blue / 255.);
      message.add(aDuration);
      osc.send(message, address);
  }

  /*
   *  Send message to control a column.
   *
   *  @param
   *  aColumn : index of the column, 0 is left, from 0 to 11.
   *  aIndexLED : index of the LED on the halo, from 0 to 30.
   *  aColor : Color target, rgb format, values from 0. to 1.
   *  aDuration : Duration of the fading to this color in second.
   */
  public void controlColumn(int aColumn, color aColor, float aDuration)
  {
      int red   = (aColor >> 16) & 0xFF;
      int green = (aColor >> 8)  & 0xFF;
      int blue  =  aColor        & 0xFF;

      OscMessage message = new OscMessage("/column");
      message.add(aColumn);
      message.add((float)red / 255.);
      message.add((float)green / 255.);
      message.add((float)blue / 255.);
      message.add(aDuration);
      osc.send(message, address);
  }

  /*
   *  Send message to control all LEDs inside a circle area.
   *
   *  @param
   *  aX : x coordinate of the center of the circle.
   *  aY : y coordinate of the center of the circle.
   *  aRadius : radius of the circle.
   *  aColor : Color target, rgb format, values from 0. to 1.
   *  aDuration : Duration of the fading to this color in second.
   */
  public void controlArea(float aX, float aY, float aRadius, color aColor, float aDuration)
  {
      int red   = (aColor >> 16) & 0xFF;
      int green = (aColor >> 8)  & 0xFF;
      int blue  =  aColor        & 0xFF;

      OscMessage message = new OscMessage("/area");
      message.add(aX);
      message.add(aY);
      message.add(aRadius);
      message.add((float)red / 255.);
      message.add((float)green / 255.);
      message.add((float)blue / 255.);
      message.add(aDuration);
      osc.send(message, address);
  }
}
