/* In Task 5, you will be adding code this surface
 * shader to support Textures
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */


Shader "Assignment3/Task5/TexturedLambertSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        /*******
         * TODO: Add Texture property
         *******/
         _MainTex ("Texture", 2D) = "white" {}
    }

    // Our Shader Program
    SubShader
    {
        CGPROGRAM

        // Define a surface shader in the surf function with
        // Lamert lighting
        #pragma surface surf Lambert

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            /*******
             * TODO: To ensure that texture tiling and offset values
             * get applied to the UV coordinates, we need to append
             * the texture name to the end of the uv coordinates, e.g
             * if our texture is called _MainTex, it should be uv_MainTex
             * or if our texture is called myTex, it should be uvmyTex
             *******/
            float2 uv_MainTex;
        };

        /*******
         * TODO: Add uniform variables for the texture here
         *******/
         sampler2D _MainTex;
         

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
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);
            /*******
             * TODO: Set surface output Albedo (Diffuse) colour by extracting
             * colour from texture using the tex2D function
             *******/
              o.Albedo = texColor.rgb;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
