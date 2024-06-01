/* This code creates the outline for our xray stencils
 * you should not need to change this
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2021, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Custom/Task7/XRayStencilOutlineShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)
    }

    SubShader
    {
        Tags { "Queue" = "Geometry" }

        Stencil
        {
            Ref 0
            Comp equal
        }

        CGPROGRAM

        // Define a surface shader in the surf function with
        // Lamert lighting and alpha (so nothing is drawn)
        #pragma surface surf Lambert

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

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
            // This shader is only meant to write to the stencil buffer
            // so don't bother doing anything with the surface
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}