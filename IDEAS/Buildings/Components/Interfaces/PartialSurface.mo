within IDEAS.Buildings.Components.Interfaces;
partial model PartialSurface "Partial model for building envelope component"

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{30,-100},{50,-80}})));

  parameter Modelica.SIunits.Angle inc
    "Inclination (tilt) angle of the wall, see IDEAS.Types.Tilt";
  parameter Modelica.SIunits.Angle azi
    "Azimuth angle of the wall, i.e. see IDEAS.Types.Azimuth, set IDEAS.Types.Azimuth.S for horizontal ceilings and floors";
  parameter Modelica.SIunits.Area A
    "Component surface area";
  parameter Real nWin = 1 "Use this factor to scale the component to nWin identical components";
  parameter Modelica.SIunits.Power QTra_design
    "Design heat losses at reference temperature of the boundary space"
    annotation (Dialog(group="Design power",tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Start temperature for each of the layers"
    annotation(Dialog(tab="Dynamics", group="Initial condition"));

  parameter Modelica.SIunits.Temperature TRef_a=291.15
    "Reference temperature of zone on side of propsBus_a, for calculation of design heat loss"
    annotation (Dialog(group="Design power",tab="Advanced"));
  parameter Boolean linIntCon_a=sim.linIntCon
    "= true, if convective heat transfer should be linearised"
    annotation (Dialog(tab="Convection"));
  parameter Modelica.SIunits.TemperatureDifference dT_nominal_a=1
    "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder"
    annotation (Dialog(tab="Convection"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  IDEAS.Buildings.Components.Interfaces.ZoneBus propsBus_a(
    numIncAndAziInBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles)
                                             "If inc = Floor, then propsbus_a should be connected to the zone above this floor.
    If inc = ceiling, then propsbus_a should be connected to the zone below this ceiling.
    If component is an outerWall, porpsBus_a should be connect to the zone."
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={100,20}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={50,20})));

  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection intCon_a(
    linearise=linIntCon_a or sim.linearise,
    dT_nominal=dT_nominal_a,
    final inc=inc,
    A=A)
    "Convective heat transfer correlation for port_a"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer
    layMul(final inc=inc, energyDynamics=energyDynamics,
    linIntCon=linIntCon_a or sim.linearise,
    A=A)
    "Multilayer component for simulating walls, windows and other surfaces"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

protected
  Modelica.Blocks.Sources.RealExpression QDesign(y=QTra_design);

  Modelica.Blocks.Sources.RealExpression aziExp(y=azi)
    "Azimuth angle expression";
  Modelica.Blocks.Sources.RealExpression incExp(y=inc)
    "Inclination angle expression";
  Modelica.Blocks.Sources.RealExpression E
    "Model internal energy";
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.PrescribedEnergy prescribedHeatFlowE
    "Component for computing conservation of energy";
  Modelica.Blocks.Sources.RealExpression Qgai
    "Heat gains across model boundary";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowQgai
    "Component for computing conservation of energy";

  IDEAS.Buildings.Components.Interfaces.ZoneBusVarMultiplicator gain(k=nWin)
    "Gain for all propsBus variable to represent nWin surfaces instead of 1"
    annotation (Placement(transformation(extent={{70,6},{88,36}})));
  IDEAS.Buildings.Components.Interfaces.ZoneBus propsBusInt(
    numIncAndAziInBus=sim.numIncAndAziInBus,
    outputAngles=sim.outputAngles)
    annotation (Placement(transformation(
        extent={{-18,-18},{18,18}},
        rotation=-90,
        origin={56,20}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={50,20})));
equation
  connect(prescribedHeatFlowE.port, propsBusInt.E);
  connect(Qgai.y,prescribedHeatFlowQgai. Q_flow);
  connect(prescribedHeatFlowQgai.port, propsBusInt.Qgai);
  connect(E.y,prescribedHeatFlowE. E);
  connect(QDesign.y, propsBusInt.QTra_design);
  connect(propsBusInt.surfCon, intCon_a.port_b) annotation (Line(
      points={{56.09,19.91},{46,19.91},{46,0},{40,0}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(layMul.port_a, propsBusInt.surfRad) annotation (Line(
      points={{10,0},{16,0},{16,19.91},{56.09,19.91}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.port_a, intCon_a.port_a) annotation (Line(
      points={{10,0},{20,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsSw_a, propsBusInt.epsSw) annotation (Line(
      points={{10,4},{20,4},{20,19.91},{56.09,19.91}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.iEpsLw_a, propsBusInt.epsLw) annotation (Line(
      points={{10,8},{18,8},{18,19.91},{56.09,19.91}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.area, propsBusInt.area) annotation (Line(
      points={{0,10},{0,19.91},{56.09,19.91}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(incExp.y, propsBusInt.inc);
  connect(aziExp.y, propsBusInt.azi);
  connect(propsBus_a, gain.propsBus_b) annotation (Line(
      points={{100,20},{94,20},{94,20.2105},{88,20.2105}},
      color={255,204,51},
      thickness=0.5));
  connect(gain.propsBus_a, propsBusInt) annotation (Line(
      points={{70,20.2105},{60,20.2105},{60,20},{56,20}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-50,-100},{50,100}})),
    Documentation(revisions="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
Add scaling to propsBus_a to allow simulation of nWin windows instead of 1
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>. This factor is not useful for wall and it is set final to 1 
for them.
</li>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Extended documentation.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed bus declarations for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
January 10, 2017, by Filip Jorissen:<br/>
Declared parameter <code>A</code> instead of using
<code>AWall</code> in 
<a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface>
IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface</a>.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/609>#609</a>.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
March 8, 2016, by Filip Jorissen:<br/>
Added energyDynamics parameter.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
February 6, 2016 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Partial model for all surfaces and windows that contains common building blocks such as material layers and parameters.
</p>
<h4>Main equations</h4>
<p>
Submodel <code>layMul</code> contains equations
for simulating conductive (and sometimes radiative) heat transfer
inside material layers.
</p>
<h4>Assumption and limitations</h4>
<p>
This model assumes 1D heat transfer, i.e. edge effects are neglected.
Mass exchange (moisture) is not modelled.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameters <code>inc</code> and <code>azi</code> may be
used to specify the inclination and azimuth/tilt angle of the surface.
Variables in <a href=modelica://IDEAS.Types.Azimuth>IDEAS.Types.Azimuth</a>
and <a href=modelica://IDEAS.Types.Tilt>IDEAS.Types.Tilt</a>
may be used for this purpose or custom variables may be defined.
Numerical values can be used directly. 
Azimuth angles should be in radians relative to the south orientation, clockwise.
Tilt angles should be in radians where an angle of 0 is the ceiling (upward) orientation
and an angle of Pi is the floor (downward) orientation.
Preferably the azimuth angle is set to zero for horizontal tilt angles, 
since this leads to more efficient code, 
although the model results will not change.
</p>
<p>
The parameter <code>nWin</code> is used in the window model to scale
the window to <code>nWin</code> identical window using the single window
model.
</p>
<h4>Options</h4>
<p>
Convection equations may be simplified (linearised) by setting <code>linIntCon_a = true</code>.
</p>
<h4>Dynamics</h4>
<p>
This model contains multiple state variables for describing the temperature state of the component.
</p>
</html>"));
end PartialSurface;
