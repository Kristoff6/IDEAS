within IDEAS.Media.Antifreeze.Validation.BaseClasses;
package PropyleneGlycolWater
  "PropyleneGlycolWater with publicly accessible medium functions"
  extends IDEAS.Media.Antifreeze.PropyleneGlycolWater;

    replaceable function testDensity_TX_a
    "Evaluate density of antifreeze-water mixture"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
    input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
    output Modelica.SIunits.Density d "Density of antifreeze-water mixture";
    algorithm
    d := density_TX_a(T = T, X_a = X_a);

    annotation (Documentation(info="<html>
<p>
Function that makes
<a href=\"modelica://IDEAS.Media.Antifreeze.density_TX_a\">
IDEAS.Media.Antifreeze.density_TX_a</a>
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end testDensity_TX_a;

  function testDynamicViscosity_TX_a
    "Evaluate dynamic viscosity of antifreeze-water mixture"
      extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
    input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
    output Modelica.SIunits.DynamicViscosity eta "Dynamic Viscosity of antifreeze-water mixture";
  algorithm
    eta := dynamicViscosity_TX_a(T = T, X_a = X_a);

    annotation (Documentation(info="<html>
<p>
Function that makes
<a href=\"modelica://IDEAS.Media.Antifreeze.dynamicViscosity_TX_a\">
IDEAS.Media.Antifreeze.dynamicViscosity_TX_a</a>
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end testDynamicViscosity_TX_a;

  function testFusionTemperature_TX_a
    "Evaluate temperature of fusion of antifreeze-water mixture"
      extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
    input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
    output Modelica.SIunits.Temperature Tf "Temperature of fusion of antifreeze-water mixture";
  algorithm
    Tf := fusionTemperature_TX_a(T = T, X_a = X_a);

    annotation (Documentation(info="<html>
<p>
Function that makes
<a href=\"modelica://IDEAS.Media.Antifreeze.fusionTemperature_TX_a\">
IDEAS.Media.Antifreeze.fusionTemperature_TX_a</a>
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end testFusionTemperature_TX_a;

  function testSpecificHeatCapacityCp_TX_a
    "Evaluate specific heat capacity of antifreeze-water mixture"
      extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
    input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
    output Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity of antifreeze-water mixture";
  algorithm
    cp := specificHeatCapacityCp_TX_a(T = T, X_a = X_a);

    annotation (Documentation(info="<html>
<p>
Function that makes
<a href=\"modelica://IDEAS.Media.Antifreeze.specificHeatCapacityCp_TX_a\">
IDEAS.Media.Antifreeze.specificHeatCapacityCp_TX_a</a>
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end testSpecificHeatCapacityCp_TX_a;

  function testThermalConductivity_TX_a
    "Evaluate thermal conductivity of antifreeze-water mixture"
      extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
    input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
    output Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity of antifreeze-water mixture";
  algorithm
    lambda := thermalConductivity_TX_a(T = T, X_a = X_a);

    annotation (Documentation(info="<html>
<p>
Function that makes
<a href=\"modelica://IDEAS.Media.Antifreeze.thermalConductivity_TX_a\">
IDEAS.Media.Antifreeze.thermalConductivity_TX_a</a>
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end testThermalConductivity_TX_a;
annotation (Documentation(info="<html>
<p>
Media implementation that extends
<a href=\"modelica://IDEAS.Media.Antifreeze\">
IDEAS.Media.Antifreeze</a>
in order to make its thermophysical property functions
publicly accessible as needed for the validation model
<a href=\"modelica://IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties\">
IDEAS.Media.Antifreeze.Validation.BaseClasses.FluidProperties</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
May 14, 2018 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end PropyleneGlycolWater;
