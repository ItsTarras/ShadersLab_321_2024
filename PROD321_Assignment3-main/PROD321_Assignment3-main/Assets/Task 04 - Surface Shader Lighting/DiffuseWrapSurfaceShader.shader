/* In Task 4, you will be adding code this surface
 * shader to create a custom lighting function for
 * diffuse wrap shading
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task4/DiffuseWrapSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)
    }

    // Our Shader Program
    SubShader
    {
        CGPROGRAM

        // Define a surface shader in the surf function
        /*******
         * TODO: Change Lighting Model
         *******/
        #pragma surface surf DiffuseWrap

        // Include cginc files for helpful functions
        #include "UnityCG.cginc"
        #include "AutoLight.cginc"
        #include "Lighting.cginc"

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;

        // The definition of our Surface Output structure for reference
        /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // diffuse color
            fixed3 Normal;  // tangent space normal, if written
            fixed3 Emission;
            half Specular;  // specular power in 0..1 range
            fixed Gloss;    // specular intensity
            fixed Alpha;    // alpha for transparencies
        };
        */


        /*******
         * TODO: Add Custom Lighting function here
         *******/
        // The code to use in your function is as follows:
        
        half4 LightingDiffuseWrap(SurfaceOutput s, half3 lightDir, half3 viewDIr, half atten)
        {
            // Calculate the Dot product of the surface normal and
            // the light direction (i.e. Lambert lighting)
            half NdotL = dot (s.Normal, lightDir);

            // Calculate the diffuse wrap colour by scaling the
            // dot product from -1...1 to 0...1
            half diff = NdotL * 0.5 + 0.5;

            // Calculate the lighting value as the albedo colour of
            // the surface, multiplied by the light colour, multipled
            // by the diffuse wrap colour, multipled by the attenuation
            // of the light
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);

            // Copy over the alpha from the surface into this fragment
            c.a = s.Alpha;

            // Return our final fragment colour
            return c;
        }
        
        


        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutput called o
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Set the surface output Albedo (Diffuse) colour to the _Color
            // variable
            o.Albedo = _Color;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
