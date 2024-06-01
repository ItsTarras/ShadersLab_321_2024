/* In Task 4, you will be adding code this surface
 * shader to support Blinn Phong lighting
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task4/BlinnPhongSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)
        /*******
         * TODO: Add Specular Colour, Specular power and 
         * specular intensity (gloss) properties here
         *******/

        _SpecColor ("Specular Color", Color) = (1,1,1,1)
        _SpecPower ("Specular Power", Range(0.1, 1)) = 1
        _Gloss ("Gloss", Range(0.0, 1.0)) = 1

    }

    // Our Shader Program
    SubShader
    {
        CGPROGRAM

        // Define a surface shader in the surf function
        /*******
         * TODO: Change Lighting Model
         *******/
        #pragma surface surf BlinnPhong

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;

        /*******
         * TODO: Add uniform variables for Specular power
         * and specular intensity (gloss) here
         *******/
        float _SpecPower;
        float _Gloss;


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


        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutput called o
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Set the surface output Albedo (Diffuse) colour to the _Color
            // variable
            o.Albedo = _Color;
            /*******
             * TODO:  Set surface output specular power and
             * specular intensity (gloss) here
             *******/

            o.Specular = _SpecPower * _SpecColor;
            o.Gloss = _Gloss;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
